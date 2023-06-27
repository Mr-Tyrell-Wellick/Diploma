//
//  SignUpInteractor.swift
//  Diploma
//
//  Created by Ульви Пашаев on 07.06.2023.
//

import RIBs
import RxRelay

struct SignUpCredentialsModel {
    let login: String
    let password: String
}

protocol SignUpRouting: ViewableRouting {
    
}

protocol SignUpPresentable: Presentable {
    func showLoadingIndicator(_ show: Bool)
    
    var listener: SignUpViewControllerListener? { get set }
}

protocol SignUpListener: AnyObject {
    func signUpDidClose()
}

final class SignUpInteractor: PresentableInteractor<SignUpPresentable>,
                              SignUpInteractable {
    
    init(
        presenter: SignUpPresentable,
        firebaseAuthenticationService: FirebaseAuthenticationService
    ) {
        self.firebaseAuthenticationService = firebaseAuthenticationService
        super.init(presenter: presenter)
        presenter.listener = self
    }
    
    override func didBecomeActive() {
        super.didBecomeActive()
        logActivate()
        
    }
    
    override func willResignActive() {
        super.willResignActive()
        logDeactivate()
    }
    
    private func subscribeOnSignUp() {
        signUpAction.compactMap { $0 }
            .do { [unowned self] _ in
                presenter.showLoadingIndicator(true)
            }
            .flatMapLatest { [unowned self] model in
                firebaseAuthenticationService.signUp(
                    login: model.login,
                    password: model.password
                )
                .catch { [unowned self] error in
                    handleError(error)
                    return .just(false)
                }
            }
            .do { [unowned self] signUpResult in
                if signUpResult {
                    print("success signUp")
                } else {
                    presenter.showLoadingIndicator(false)
                    // TODO: handle error
                    print("no success signUp")
                }
            }
            .filter { $0 }
            .flatMapLatest { [unowned self] _ in
                firebaseAuthenticationService.sendVerificationEmail()
            }
            .bind { [unowned self] sendResult in
                presenter.showLoadingIndicator(false)
                if sendResult {
                    // TODO: показывать алерт, что отправили письмо на почту
                    print("success email send")
                } else {
                    // TODO: handle error
                    print("no success email send")
                }
            }
            .disposeOnDeactivate(interactor: self)
    }
    
    private func handleError(_ error: Error) {
        
    }
    
    weak var listener: SignUpListener?
    weak var router: SignUpRouting?
    
    private let firebaseAuthenticationService: FirebaseAuthenticationService
    private let signUpAction = BehaviorRelay<SignUpCredentialsModel?>(value: nil)
}

// MARK: - SignUpViewControllerListener

extension SignUpInteractor: SignUpViewControllerListener {
    func didClose() {
        listener?.signUpDidClose()
    }
    
    func didTapSignUp(_ model: SignUpCredentialsModel) {
        signUpAction.accept(model)
    }
}
