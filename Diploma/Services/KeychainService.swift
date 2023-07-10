//
//  KeychainService.swift
//  Diploma
//
//  Created by Ульви Пашаев on 04.07.2023.
//

import Foundation

protocol KeychainService {
    func save(key: String, data: Data) -> OSStatus
    func load(key: String) -> Data?
}


extension KeychainService {
    func save(key: String = "com.diploma.credentials", data: Data) -> OSStatus {
        save(key: key, data: data)
    }
    
    func load(key: String = "com.diploma.credentials") -> Data? {
        load(key: key)
    }
}

class KeychainServiceImpl: KeychainService {
    func save(key: String = "com.diploma.credentials", data: Data) -> OSStatus {
        let query = [ kSecClass as String: kSecClassGenericPassword as String,
                      kSecAttrAccount as String: key,
                      kSecValueData as String: data
        ] as [String: Any]
        SecItemDelete(query as CFDictionary)
        let status = SecItemAdd(query as CFDictionary, nil)
        guard status != noErr else { return status }
        return status
    }
    
    func load(key: String = "com.diploma.credentials") -> Data? {
        let query = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key,
            kSecReturnData as String: kCFBooleanTrue!,
            kSecMatchLimit as String: kSecMatchLimitOne
        ] as [String: Any]
        
        var dataTypeRef: AnyObject?
        
        let status: OSStatus = SecItemCopyMatching(query as CFDictionary, &dataTypeRef)
        
        if status == noErr {
            guard let data = dataTypeRef as? Data? else {
                return nil
            }
            return data
        } else {
            return nil
        }
    }
}

extension Data {
    static func encode<T: Encodable>(object: T) -> Data? {
        try? JSONEncoder().encode(object)
    }
    
    static func decode<T: Decodable>(data: Data, as type: T.Type) -> T? {
        try? JSONDecoder().decode(T.self, from: data)
    }
}
