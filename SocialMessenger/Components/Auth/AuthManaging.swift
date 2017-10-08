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
    var authCredential: AuthCredential? { get }
    
    var authStateChangedObservable: Observable<Bool> { get }
    
    func signUp(withEmail email: String, password: String) -> Observable<Void>
    
    func signIn(withEmail email: String, password: String) -> Observable<Void>
    
}

extension AuthManaging {
    var isAuthenticated: Bool {
        return authCredential != nil
    }
}
