//
//  AuthApiServiceType.swift
//  SocialMessenger
//
//  Created by Khanh Pham on 10/5/17.
//  Copyright © 2017 Khanh Pham. All rights reserved.
//

import Foundation
import RxSwift

protocol AuthApiServiceType {
    
    func signUp(withEmail email: String, password: String) -> Observable<Void>
    
    func signIn(withEmail email: String, password: String) -> Observable<AuthCredential>
}
