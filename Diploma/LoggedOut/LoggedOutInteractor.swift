//
//  LoggedOutInteractor.swift
//  Diploma
//
//  Created by Ульви Пашаев on 07.06.2023.
//

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
}

protocol LoggedOutPresentable: Presentable {
    func showLoadingIndicator(_ show: Bool)

    var listener: LoggedOutViewControllerListener? { get set }
}

final class LoggedOutInteractor: PresentableInteractor<LoggedOutPresentable>, LoggedOutInteractable {

    weak var router: LoggedOutRouting?

    init(
        presenter: LoggedOutPresentable,
        biometryAuthenticationService: BiometryAuthenticationService,
        firebaseAuthentication: FirebaseAuthenticationService
    ) {
        self.biometryAuthenticationService = biometryAuthenticationService
        self.firebaseAuthentication = firebaseAuthentication
        super.init(presenter: presenter)
        presenter.listener = self
    }

    override func didBecomeActive() {
        logActivate()
        subscribeOnBiometry()
        subscribeOnSignUp()
        subscribeOnLogIn()
    }

    override func willResignActive() {
        logDeactivate()
    }

    private func subscribeOnBiometry() {
        biometryValue
            .filter { $0 }
            .flatMapLatest { [unowned self] _ -> Single<Bool> in
                biometryAuthenticationService
                    .authorize()
                    .catch { [unowned self] _ in
                        handleBiometryError()
                        return .just(false)
                    }
            }
            .filter { $0 }
            .bind(onNext: { success in
                print(success)
            })
            .disposeOnDeactivate(interactor: self)
    }

    private func subscribeOnLogIn() {
        logInAction.compactMap { $0 }
            .do { [unowned self] _ in
                presenter.showLoadingIndicator(true)
            }
            .flatMapLatest { [unowned self] model in
                firebaseAuthentication.login(
                    login: model.login,
                    password: model.password
                )
                .catch { [unowned self] error in
                    handleError(error)
                    return .just(false)
                }
            }
            .bind { [unowned self] result in
                presenter.showLoadingIndicator(false)

                if result {
                    print("sucess auth")
                } else {
                    print("not success auth")
                }
            }
            .disposeOnDeactivate(interactor: self)
    }

    private func handleBiometryError() {
        print("error")
    }

    private func subscribeOnSignUp() {
        signUpAction
            .filter { $0 }
            .bind { [unowned self] _ in
                router?.routeToSignUp()
            }
            .disposeOnDeactivate(interactor: self)
    }

    private func handleError(_ error: Error) {
        guard let error = error as? FirebaseAuthenticationServiceError else { return }
        print("error: \(error.localizedDescription)")
    }


    private let biometryAuthenticationService: BiometryAuthenticationService
    private let firebaseAuthentication: FirebaseAuthenticationService

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
}

// MARK: - SignUpListener

extension LoggedOutInteractor {
    func signUpDidClose() {
        router?.signUpDidClose()
    }
}
