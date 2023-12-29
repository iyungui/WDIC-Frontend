//
//  KeyChain.swift
//  WDIC
//
//  Created by 이융의 on 12/18/23.
//

import Foundation
import Security

class KeyChain {
    // Create
    @discardableResult
    class func create(key: String, token: String) -> Bool {
        let query: NSDictionary = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: key,
            kSecValueData: token.data(using: .utf8, allowLossyConversion: false) as Any
        ]

        SecItemDelete(query)
        
        let status = SecItemAdd(query, nil)
        if status != noErr {
            return false
        }
        
        return true
    }
    
    // Read
    class func read(key: String) -> String? {
        let query: NSDictionary = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: key,
            kSecReturnData: kCFBooleanTrue as Any,
            kSecMatchLimit: kSecMatchLimitOne
        ]
        
        var dataTypeRef: AnyObject?
        let status = SecItemCopyMatching(query, &dataTypeRef)
        
        if status == errSecSuccess {
            if let retrievedData: Data = dataTypeRef as? Data {
                let value = String(data: retrievedData, encoding: String.Encoding.utf8)
                return value
            } else { return nil }
        } else {
            return nil
        }
    }
    
    // Delete
    @discardableResult
    class func delete(key: String) -> Bool {
        let query: NSDictionary = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: key
        ]
        let status = SecItemDelete(query)
        
        if status != noErr {
            return false
        }
        
        return true
    }
}
