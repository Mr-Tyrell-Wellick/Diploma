//
//  UserDefaultsStorage.swift
//  Diploma
//
//  Created by Ульви Пашаев on 04.07.2023.
//

import SwiftyUserDefaults

extension DefaultsKeys {
    var isBiometryEnabled: DefaultsKey<Bool?> {
        .init("isBiometryEnabled", defaultValue: nil)
    }
}

protocol UserDefaultsStorage {
    var isBiometryEnabled: Bool? { get }
}

protocol UserDefaultsMutableStorage: UserDefaultsStorage {
    func setIsBiometryEnabled(_ value: Bool)
}

final class UserDefaultsStorageImpl: UserDefaultsMutableStorage {
    
    // MARK: - UserDefaultsStorage
    
    var isBiometryEnabled: Bool? {
        Defaults[\.isBiometryEnabled]
    }
    
    // MARK: - UserDefaultsMutableStorage
    
    func setIsBiometryEnabled(_ value: Bool) {
        Defaults[\.isBiometryEnabled] = value
    }
}
