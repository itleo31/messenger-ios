//
//  AuthCredentialsStorage.swift
//  SocialMessenger
//
//  Created by Khanh Pham on 9/1/17.
//  Copyright © 2017 Khanh Pham. All rights reserved.
//

import Foundation
import KeychainAccess
import SwiftyUserDefaults

protocol AuthCredentialStorageType {
    
    func save(_ credentials: AuthCredential?)
    
    func load() -> AuthCredential?
    
}

class KeyChainAuthCredentialStorage: AuthCredentialStorageType {
    
    let keychain = Keychain(service: Bundle.main.bundleIdentifier ?? "joltmate")
    
    private let tokenKey = "auth.token"
    
    func save(_ credentials: AuthCredential?) {
        if let credentials = credentials {
            keychain[tokenKey] = credentials.token
        } else {
            keychain[tokenKey] = nil
        }
    }
    
    func load() -> AuthCredential? {
        if let token = keychain[tokenKey] {
            return AuthCredential(token: token)
        }
        
        return nil
    }
    
}

class UserDefaultsAuthCredentialStorage: AuthCredentialStorageType {
    func save(_ credentials: AuthCredential?) {
        if let credentials = credentials {
            Defaults[.authTokenKey] = credentials.token
        } else {
            Defaults[.authTokenKey] = nil
        }
    }
    
    func load() -> AuthCredential? {
        if let token = Defaults[.authTokenKey] {
            return AuthCredential(token: token)
        }
        
        return nil
    }
}

extension DefaultsKeys {
    static let authTokenKey = DefaultsKey<String?>("authTokenKey")
}
