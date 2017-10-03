//
//  LogInViewModel.swift
//  SocialMessenger
//
//  Created by Khanh Pham on 9/1/17.
//  Copyright © 2017 Khanh Pham. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift


class LogInViewModel {
    
    let authManager: AuthManaging
    
    let disposeBag = DisposeBag()
    
    init(authManager: AuthManaging) {
        self.authManager = authManager
    }
    
    func loginFacebook(viewController: UIViewController?) {
//        authManager.login(social: .facebook, viewController: viewController)
    }
    
}
