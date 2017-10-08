//
//  FacebookSDKRxExt.swift
//  SocialMessenger
//
//  Created by Khanh Pham on 10/5/17.
//  Copyright © 2017 Khanh Pham. All rights reserved.
//

import Foundation
import FacebookCore
import FacebookLogin
import RxSwift

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
