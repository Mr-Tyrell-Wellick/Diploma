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

struct KeychainCredentialsModel: Codable {
    let login: String
    let password: String
}

protocol FirebaseAuthenticationService {
    func login(login: String, password: String) -> Single<Bool>
    func signUp(login: String, password: String) -> Single<Bool>
    func sendVerificationEmail() -> Single<Bool>
}

enum FirebaseAuthenticationServiceError: Error {
    case emailNotVerified
    case failedToSaveToKeychain
    
    var localizedDescription: String {
        switch self {
        case .emailNotVerified:
            return "Почта не подтверждена"
        case .failedToSaveToKeychain:
            return "Ошибка сохранения данных в защищенное хранилище"
        }
    }
}

final class FirebaseAuthenticationServiceImpl: FirebaseAuthenticationService {
    
    private enum FirebaseAuthMethod {
        case logIn
        case signUp
    }
    
    init(
        userStream: UserMutableStream,
        keychainService: KeychainService
    ) {
        self.userStream = userStream
        self.keychainService = keychainService
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
        let completion: (AuthDataResult?, Error?) -> Void = { [weak self] result, error in
            guard let self else { return }
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
            if type == .logIn {
                self.userStream.updateUser(user)
            }
            guard let credentialData = Data.encode(
                object: KeychainCredentialsModel(
                    login: login,
                    password: password
                )
            ),
                  self.keychainService.save(data: credentialData) == noErr else {
                observer(.failure(FirebaseAuthenticationServiceError.failedToSaveToKeychain))
                return
            }
            observer(.success(true))
        }
        switch type {
        case .logIn:
            Auth.auth().signIn(withEmail: login, password: password, completion: completion)
        case .signUp:
            Auth.auth().createUser(withEmail: login, password: password, completion: completion)
        }
    }
    
    private let keychainService: KeychainService
    private let userStream: UserMutableStream
}
