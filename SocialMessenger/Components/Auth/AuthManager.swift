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
import FacebookCore
import FacebookLogin

enum AuthError: Error {
    case notAuthenticated
    case userCancelled
    case facebookDeclinedPermissions
    case facebookError(Error)
}

class AuthManager: AuthManaging {
    
    let authStorage: AuthCredentialStorageType
    let logginManager = LoginManager()
    
    init(authStorage: AuthCredentialStorageType) {
        self.authStorage = authStorage
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey : Any]?) -> Bool {
        return SDKApplicationDelegate.shared.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any]) -> Bool {
        return SDKApplicationDelegate.shared.application(app, open: url, options: options)
    }
    
    var authCredential: AuthCredential? {
        get {
            return authStorage.load()
        }
        set {
            authStorage.save(newValue)
        }
    }
    
    func login(social: SocialType, viewController: UIViewController?) -> Observable<AuthCredential> {
        
        return logginManager.rx.logIn([.publicProfile, .userFriends], viewController: viewController)
            .map { (loginResult) -> AuthCredential in
                switch loginResult {
                case .cancelled:
                    throw AuthError.userCancelled
                case .failed(let error):
                    throw AuthError.facebookError(error)
                case .success(_, let declinedPermissions, let token):
                    if !declinedPermissions.isEmpty {
                        throw AuthError.facebookDeclinedPermissions
                    }
                    
                    return AuthCredential(token: token.authenticationToken)
                }
            }
            .flatMapLatest { credentials -> Observable<AuthCredential> in
                
                self.authCredential = credentials
                return .just(credentials)
            }
    }
}

extension LoginManager: ReactiveCompatible {
    
}

extension Reactive where Base: LoginManager {
    func logIn(_ permissions: [ReadPermission] = [.publicProfile],
               viewController: UIViewController? = nil) -> Observable<LoginResult> {
        return Observable.create({ [weak base] (observer) -> Disposable in
            guard let manager = base else {
                observer.onCompleted()
                return Disposables.create()
            }
            
            manager.logIn(permissions, viewController: viewController) { loginResult in
                observer.onNextAndCompleted(loginResult)
            }
            return Disposables.create()
        })
    }
    
    func logIn(_ permissions: [PublishPermission] = [.publishActions],
               viewController: UIViewController? = nil) -> Observable<LoginResult> {
        return Observable.create({ [weak base] (observer) -> Disposable in
            guard let manager = base else {
                observer.onCompleted()
                return Disposables.create()
            }
            
            manager.logIn(permissions, viewController: viewController) { loginResult in
                observer.onNextAndCompleted(loginResult)
            }
            return Disposables.create()
        })
    }
}
