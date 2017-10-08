//
//  AuthManager.swift
//  SocialMessenger
//
//  Created by Khanh Pham on 9/1/17.
//  Copyright © 2017 Khanh Pham. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

class AuthManager: AuthManaging {
    
    let authStorage: AuthCredentialStorageType
    let authApiService: AuthApiServiceType
    
    private(set) var authCredential: AuthCredential? {
        didSet {
            self.authStateChangedSubject.onNext(self.isAuthenticated)
        }
    }
    
    private let authStateChangedSubject = PublishSubject<Bool>()
    var authStateChangedObservable: Observable<Bool> {
        return authStateChangedSubject.asObservable().shareReplay(1)
    }
    
    init(authStorage: AuthCredentialStorageType, authApiService: AuthApiServiceType) {
        self.authStorage = authStorage
        self.authApiService = authApiService
        self.authCredential = authStorage.load()
        
        self.authStateChangedSubject.onNext(self.isAuthenticated)
    }
    
    func signUp(withEmail email: String, password: String) -> Observable<Void> {
        return authApiService.signUp(withEmail: email, password: password)
            .flatMapLatest { _ in self.authApiService.signIn(withEmail: email, password: password) }
            .flatMapLatest({ (token) -> Observable<Void> in
                self.authCredential = token
                return .just(())
            })
    }
    
    func signIn(withEmail email: String, password: String) -> Observable<Void> {
        return authApiService.signIn(withEmail: email, password: password)
            .flatMapLatest({ (token) -> Observable<Void> in
                self.authCredential = token
                return .just(())
            })
    }
    
    
}

