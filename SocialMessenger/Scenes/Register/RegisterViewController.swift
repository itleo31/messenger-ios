//
//  RegisterViewController.swift
//  SocialMessenger
//
//  Created by Khanh Pham on 10/5/17.
//  Copyright © 2017 Khanh Pham. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class RegisterViewController: UIViewController, BindableType {
    
    typealias ViewModelType = RegisterViewModel
    
    var viewModel: RegisterViewModel!
    let disposeBag = DisposeBag()
    
    let app = AppComponents.shared
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var submitButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let vm = RegisterViewModel(dataValidator: app.dataValidator, authManager: app.authManager)
        bindViewModel(to: vm)
    }
    
    func bindViewModel() {
        
        viewModel.email.bidirectionalBind(with: emailTextField.rx.text)
            .disposed(by: disposeBag)
        
        viewModel.password.bidirectionalBind(with: passwordTextField.rx.text)
            .disposed(by: disposeBag)
        
        submitButton.rx.tap
            .asObservable()
            .debounce(0.25, scheduler: MainScheduler.instance)
            .skipWhile { [unowned self] _ in self.viewModel.isLoading.value }
            .subscribe(onNext: { [unowned self] _ in
                self.viewModel.submit()
            })
            .disposed(by: disposeBag)
        
        bindAnimateWith(variable: viewModel.isLoading)
            .disposed(by: disposeBag)
        
        ToastHelper.bindWith(viewModel.alertMessage.asObservable())
            .disposed(by: disposeBag)
        
    }
}
