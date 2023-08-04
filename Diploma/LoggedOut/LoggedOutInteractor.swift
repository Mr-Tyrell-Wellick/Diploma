//
//  LoggedOutInteractor.swift
//  Diploma
//
//  Created by Ульви Пашаев on 07.06.2023.
//

import Foundation
import RIBs
import RxRelay
import RxSwift

struct LoginCredentialsModel {
    let login: String
    let password: String
}

protocol LoggedOutRouting: ViewableRouting {
    func routeToSignUp()
    func signUpDidClose()
    func closeSignUp()
}

protocol LoggedOutPresentable: Presentable {
    func showLoadingIndicator(_ show: Bool)
    func fillCredentials(_ credentialModel: KeychainCredentialsModel)
    func configureBiometryButton(_ isEnabled: Bool)
    
    var listener: LoggedOutViewControllerListener? { get set }
}

protocol LoggedOutListener: AnyObject {
    func didSuccessLogin()
}

final class LoggedOutInteractor: PresentableInteractor<LoggedOutPresentable>, LoggedOutInteractable {
    
    weak var router: LoggedOutRouting?
    weak var listener: LoggedOutListener?
    
    init(
        presenter: LoggedOutPresentable,
        biometryAuthenticationService: BiometryAuthenticationService,
        firebaseAuthentication: FirebaseAuthenticationService,
        keychainService: KeychainService,
        userDefaults: UserDefaultsMutableStorage
    ) {
        self.biometryAuthenticationService = biometryAuthenticationService
        self.firebaseAuthentication = firebaseAuthentication
        self.keychainService = keychainService
        self.userDefaults = userDefaults
        super.init(presenter: presenter)
        presenter.listener = self
    }
    
    override func didBecomeActive() {
        logActivate()
        subscribeOnBiometry()
        subscribeOnSignUp()
        subscribeOnLogIn()
        subscribeOnUiReady()
    }
    
    override func willResignActive() {
        logDeactivate()
    }
    
    private func subscribeOnUiReady() {
        uiReady
            .filter { $0 }
            .do { [unowned self] _ in
                presenter.configureBiometryButton(userDefaults.isBiometryEnabled ?? false)
            }
            .map {[unowned self] _ in
                userDefaults.isBiometryEnabled ?? false
            }
            .filter { $0 }
            .compactMap { [unowned self] _ -> KeychainCredentialsModel? in
                guard let data = keychainService.load(),
                      let model = Data.decode(
                        data: data,
                        as: KeychainCredentialsModel.self
                      ) else { return nil }
                return model
            }
            .do { [unowned self] credentialsModel in
                presenter.fillCredentials(credentialsModel)
                presenter.showLoadingIndicator(true)
            }
            .flatMapLatest { [unowned self] credentialsModel in
                firebaseAuthentication.login(
                    login: credentialsModel.login,
                    password: credentialsModel.password
                )
                .catch { [unowned self] error in
                    handleAuthError(error)
                    return .just(false)
                }
            }
            .bind { [unowned self] success in
                presenter.showLoadingIndicator(false)
                if success {
                    listener?.didSuccessLogin()
                    print("success auth")
                } else {
                    print("not success auth")
                }
            }
            .disposeOnDeactivate(interactor: self)
    }
    
    private func subscribeOnBiometry() {
        biometryValue
            .filter { $0 }
            .withLatestFrom(uiReady)
            .filter { $0 }
            .flatMapLatest { [unowned self] _ -> Single<Bool> in
                biometryAuthenticationService
                    .authorize()
                    .catch { [unowned self] error in
                        handleBiometryError(error)
                        return .just(false)
                    }
            }
            .filter { $0 }
            .compactMap { [unowned self] _ -> KeychainCredentialsModel? in
                guard let data = keychainService.load(),
                      let model = Data.decode(
                        data: data,
                        as: KeychainCredentialsModel.self
                      ) else { return nil }
                return model
            }
            .do { [unowned self] credenstialsModel in
                presenter.fillCredentials(credenstialsModel)
                presenter.showLoadingIndicator(true)
            }
            .flatMapLatest { [unowned self] credentialsModel in
                firebaseAuthentication.login(
                    login: credentialsModel.login,
                    password: credentialsModel.password
                )
                .catch { [unowned self] error in
                    handleAuthError(error)
                    return .just(false)
                }
            }
            .bind { [unowned self] success in
                presenter.showLoadingIndicator(false)
                if success {
                    listener?.didSuccessLogin()
                    print("success auth")
                } else {
                    print("not success auth")
                }
            }
            .disposeOnDeactivate(interactor: self)
    }
    
    private func subscribeOnLogIn() {
        Observable
            .combineLatest(logInAction, uiReady)
            .filter { $0.1 }
            .compactMap { $0.0 }
            .do { [unowned self] _ in
                presenter.showLoadingIndicator(true)
            }
            .flatMapLatest { [unowned self] model in
                firebaseAuthentication.login(
                    login: model.login,
                    password: model.password
                )
                .catch { [unowned self] error in
                    handleAuthError(error)
                    return .just(false)
                }
            }
            .do { [unowned self] success in
                presenter.showLoadingIndicator(false)
                if success {
                    print("success auth")
                } else {
                    print("not success auth")
                }
            }
            .filter { $0 }
            .flatMapLatest { [unowned self] _ in
                biometryAuthenticationService
                    .authorize()
                    .catch { [unowned self] error in
                        handleBiometryError(error)
                        return .just(false)
                    }
            }
            .bind { [unowned self] isBiometrySuccess in
                userDefaults.setIsBiometryEnabled(isBiometrySuccess)
                listener?.didSuccessLogin()
            }
            .disposeOnDeactivate(interactor: self)
    }
    
    private func handleBiometryError(_ error: Error) {
        guard let error = error as? BiometryAuthError else {
            return
        }
        switch error {
        case .canNotEvaluatePolicyOnDevice, .userDismissedFaceIDUse:
            userDefaults.setIsBiometryEnabled(false)
        }
    }
    
    private func subscribeOnSignUp() {
        signUpAction
            .filter { $0 }
            .withLatestFrom(uiReady)
            .filter { $0 }
            .bind { [unowned self] _ in
                router?.routeToSignUp()
            }
            .disposeOnDeactivate(interactor: self)
    }
    
    private func handleAuthError(_ error: Error) {
        guard let error = error as? FirebaseAuthenticationServiceError else { return }
        print("error: \(error.localizedDescription)")
    }
    
    private let biometryAuthenticationService: BiometryAuthenticationService
    private let firebaseAuthentication: FirebaseAuthenticationService
    private let keychainService: KeychainService
    private let userDefaults: UserDefaultsMutableStorage
    
    private let uiReady = BehaviorRelay<Bool>(value: false)
    private let biometryValue = BehaviorRelay<Bool>(value: false)
    private let signUpAction = BehaviorRelay<Bool>(value: false)
    private let logInAction = BehaviorRelay<LoginCredentialsModel?>(value: nil)
}

// MARK: - LoggedOutViewControllerListener

extension LoggedOutInteractor: LoggedOutViewControllerListener {
    func didTapBiometry() {
        biometryValue.accept(true)
    }
    
    func didTapSignUp() {
        signUpAction.accept(true)
    }
    
    func didTapLogIn(_ model: LoginCredentialsModel) {
        logInAction.accept(model)
    }
    
    func viewDidLoad() {
        uiReady.accept(true)
    }
}

// MARK: - SignUpListener

extension LoggedOutInteractor {
    func signUpDidClose() {
        router?.signUpDidClose()
    }
    
    func closeSignUp() {
        router?.closeSignUp()
    }
}
