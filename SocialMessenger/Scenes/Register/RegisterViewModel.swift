//
//  RegisterViewModel.swift
//  SocialMessenger
//
//  Created by Khanh Pham on 10/5/17.
//  Copyright © 2017 Khanh Pham. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class RegisterViewModel {
    
    let email = Variable<String>("")
    let password = Variable<String>("")
    let isLoading = Variable<Bool>(false)
    
    let alertMessage = Variable<String>("")
    
    private let disposeBag = DisposeBag()
    
    let dataValidator: DataValidator
    let authManager: AuthManaging
    
    init(dataValidator: DataValidator, authManager: AuthManaging) {
        self.dataValidator = dataValidator
        self.authManager = authManager
    }
    
    func submit() {
        if !validate() {
            return
        }
        
        let observable = authManager.signUp(withEmail: email.value.trimmed, password: password.value.trimmed).shareReplay(1)
        observable.map { _ in false }.startWith(true)
            .catchErrorJustReturn(false)
            .bind(to: isLoading)
            .disposed(by: disposeBag)
        
        observable
            .subscribe(
                onError: { [unowned self] error in
                    self.alertMessage.value = error.message
                }
            )
            .disposed(by: disposeBag)
    }
    
    private func validate() -> Bool {
        var validateMessages: [String] = []
        if let msg = dataValidator.validate(email: email.value.trimmed) {
            validateMessages.append(msg)
        }
        if let msg = dataValidator.validate(password: password.value.trimmed) {
            validateMessages.append(msg)
        }
        
        if !validateMessages.isEmpty {
            alertMessage.value = validateMessages.joined(separator: "\n")
            return false
        }
        
        return true
    }
}
