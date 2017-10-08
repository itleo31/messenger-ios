//
//  ForgotPasswordViewController.swift
//  SocialMessenger
//
//  Created by Khanh Pham on 10/5/17.
//  Copyright © 2017 Khanh Pham. All rights reserved.
//

import UIKit

class ForgotPasswordViewController: UIViewController, BindableType {
    
    typealias ViewModelType = ForgotPasswordViewModel
    
    var viewModel: ForgotPasswordViewModel!
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var submitButton: UIButton!
    
    func bindViewModel() {
        
    }
}
