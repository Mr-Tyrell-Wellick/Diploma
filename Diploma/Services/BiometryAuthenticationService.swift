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

enum BiometryAuthError: Error {
    case canNotEvaluatePolicyOnDevice
    case userDismissedFaceIDUse
}

final class BiometryAuthenticationServiceImpl: BiometryAuthenticationService {
    private let context = LAContext()
    private let policy: LAPolicy = .deviceOwnerAuthenticationWithBiometrics
    private var error: NSError?
    
    func authorize() -> Single<Bool> {
        .create { [unowned self] observer in
            let result = context.canEvaluatePolicy(policy, error: &error)
            if result {
                context.evaluatePolicy(
                    policy,
                    localizedReason:
                        Strings.biometryUsageDescription.localized
                ) { result, error in
                    DispatchQueue.main.async {
                        guard let error else {
                            observer(.success(result))
                            return
                        }
                        if (error as NSError).code == LocalAuthentication.LAError.biometryNotAvailable.rawValue {
                            observer(.failure(BiometryAuthError.userDismissedFaceIDUse))
                        } else {
                            observer(.failure(error))
                        }
                    }
                }
            } else {
                observer(.failure(BiometryAuthError.canNotEvaluatePolicyOnDevice))
            }
            return Disposables.create { }
        }
    }
}
