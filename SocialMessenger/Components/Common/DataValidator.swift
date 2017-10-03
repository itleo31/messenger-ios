//
//  DataValidator.swift
//  JoltMate
//
//  Created by Khanh Pham on 8/21/17.
//  Copyright © 2017 Khanh Pham. All rights reserved.
//

import Foundation

class DataValidator: NSObject {
    static let shared = DataValidator()
    
    func validate(email: String) -> String? {
        if email.isEmpty {
            return "Email is required"
        }
        
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        if !NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: email) {
            return "Email is invalid"
        }
        
        return nil
    }
    
    func validate(password: String) -> String? {
        if password.isEmpty {
            return "Password is required"
        }
        if password.characters.count < 6 {
            return "Password must be at least 6 characters"
        }
        
        return nil
    }
    
    func validate(name: String) -> Bool {
        return !name.trimWhitespaces().isEmpty
    }
    
    
}
