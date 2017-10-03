//
//  AuthManaging.swift
//  SocialMessenger
//
//  Created by Khanh Pham on 9/1/17.
//  Copyright © 2017 Khanh Pham. All rights reserved.
//

import Foundation
import UIKit
import RxCocoa
import RxSwift

protocol AuthManaging {
    var authCredential: AuthCredential? { get set }
    
    @discardableResult
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey : Any]?) -> Bool
    
    @discardableResult
    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any]) -> Bool
    
    func login(social: SocialType, viewController: UIViewController?) -> Observable<AuthCredential>
}

enum SocialType {
    case facebook
}

extension AuthManaging {
    var isAuthenticated: Bool {
        return authCredential != nil
    }
}
