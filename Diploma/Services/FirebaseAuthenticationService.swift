//
//  FirebaseAuthenticationService.swift
//  Diploma
//
//  Created by Ульви Пашаев on 23.06.2023.
//

import Foundation
import Firebase
import FirebaseAuth
import RxSwift

protocol FirebaseAuthenticationService {
    func login(login: String, password: String) -> Single<Bool>
    func signUp(login: String, password: String) -> Single<Bool>
    func sendVerificationEmail() -> Single<Bool>
}

enum FirebaseAuthenticationServiceError: Error {
    case emailNotVerified

    var localizedDescription: String {
        switch self {
        case .emailNotVerified:
            return "Почта не подтверждена"
        }
    }
}

final class FirebaseAuthenticationServiceImpl: FirebaseAuthenticationService {

    private enum FirebaseAuthMethod {
        case logIn
        case signUp
    }

    init(userStream: UserMutableStream) {
        self.userStream = userStream
    }

    func login(login: String, password: String) -> Single<Bool> {
        .create { [unowned self] observer in
            performFirebaseAuthMethod(
                .logIn,
                login: login,
                password: password,
                observer: observer
            )
            return Disposables.create { }
        }
    }

    func signUp(login: String, password: String) -> Single<Bool> {
        .create { [unowned self] observer in
            performFirebaseAuthMethod(
                .signUp,
                login: login,
                password: password,
                observer: observer
            )
            return Disposables.create { }
        }
    }

    func sendVerificationEmail() -> Single<Bool> {
        .create { observer in
            Auth.auth().currentUser?.sendEmailVerification { error in
                guard let error else {
                    observer(.success(true))
                    return
                }
                observer(.failure(error))
            }
            return Disposables.create { }
        }
    }

    private func performFirebaseAuthMethod(
        _ type: FirebaseAuthMethod,
        login: String,
        password: String,
        observer: @escaping (Result<Bool, Error>) -> Void
    ) {
        let completion: (AuthDataResult?, Error?) -> Void = { [unowned self] result, error in
            guard let result else {
                guard let error else { return }
                observer(.failure(error))
                return
            }
            if type == .logIn && !result.user.isEmailVerified {
                observer(.failure(FirebaseAuthenticationServiceError.emailNotVerified))
                return
            }
            let user = User(
                name: result.user.displayName ?? "empty name",
                email: result.user.email ?? "empty email"
            )
            userStream.updateUser(user)
            observer(.success(true))
        }
        switch type {
        case .logIn:
            Auth.auth().signIn(withEmail: login, password: password, completion: completion)
        case .signUp:
            Auth.auth().createUser(withEmail: login, password: password, completion: completion)
        }
    }
    private let userStream: UserMutableStream
}
