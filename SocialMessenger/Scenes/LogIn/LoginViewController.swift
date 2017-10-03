//
//  LoginViewController.swift
//  SocialMessenger
//
//  Created by Khanh Pham on 9/1/17.
//  Copyright © 2017 Khanh Pham. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class LogInViewController: UIViewController, BindableType {
    
    typealias ViewModelType = LogInViewModel
    
    var viewModel: LogInViewModel!
    @IBOutlet weak var loginFBButton: UIButton!
    
    
    func bindViewModel() {
//        loginFBButton.rx.action = viewModel.loginFacebookAction(viewController: self)
    }
}
