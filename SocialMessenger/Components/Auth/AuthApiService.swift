//
//  AuthApiService.swift
//  SocialMessenger
//
//  Created by Khanh Pham on 10/5/17.
//  Copyright © 2017 Khanh Pham. All rights reserved.
//

import Foundation
import RxSwift

class AuthApiService: AuthApiServiceType {
    let apiClient: ApiClientType
    
    init(apiClient: ApiClientType) {
        self.apiClient = apiClient
    }
    
    func signUp(withEmail email: String, password: String) -> Observable<Void> {
        let params: [String: Any] = [
            "email": email,
            "password": password
        ]
        return apiClient.requestJSON(.post, path: "/auth/register", parameters: params)
            .ignoreValue()
    }
    
    func signIn(withEmail email: String, password: String) -> Observable<AuthCredential> {
        let params: [String: Any] = [
            "email": email,
            "password": password
        ]
        return apiClient.requestJSON(.post, path: "auth/login", parameters: params)
            .map { AuthCredential(json: $0) }
    }
}
