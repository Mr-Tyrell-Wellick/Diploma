//
//  BiometryAuthenticationService.swift
//  Diploma
//
//  Created by Ульви Пашаев on 20.06.2023.
//

import Foundation
import LocalAuthentication
import RxSwift

protocol BiometryAuthenticationService {
    func authorize() -> Single<Bool>
}

final class BiometryAuthenticationServiceImpl: BiometryAuthenticationService {
    private let context = LAContext()
    private let policy: LAPolicy = .deviceOwnerAuthenticationWithBiometrics
    private var error: NSError?

    func authorize() -> Single<Bool> {
        .create { [unowned self] observer in
            let result = context.canEvaluatePolicy(policy, error: &error)
            if result {
                context.evaluatePolicy(policy, localizedReason: "Verify your Identity") { result, error in
                    guard let error else {
                        observer(.success(result))
                        return
                    }
                    observer(.failure(error))
                }
            } else {
                observer(.success(false))
            }
            return Disposables.create { }
        }
    }
}
