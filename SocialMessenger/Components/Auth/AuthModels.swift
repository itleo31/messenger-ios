//
//  AuthModels.swift
//  SocialMessenger
//
//  Created by Khanh Pham on 9/1/17.
//  Copyright © 2017 Khanh Pham. All rights reserved.
//

import Foundation
import SwiftyJSON

class AuthCredential {
    let token: String
    
    init(token: String) {
        self.token = token
    }
    
    init(json: JSON) {
        self.token = json["access_token"].stringValue
    }
}
