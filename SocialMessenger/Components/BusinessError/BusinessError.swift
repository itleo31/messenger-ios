//
//  BusinessError.swift
//  SocialMessengerTests
//
//  Created by Khanh Pham on 10/5/17.
//  Copyright © 2017 Khanh Pham. All rights reserved.
//

import Foundation

enum BusinessError: Error {
    case unauthorized
    case apiError(message: String)
    case unknown(Error?)
}

extension BusinessError {
    var message: String {
        switch self {
        case .unauthorized:
            return "Unauthorized, please sign in again"
        case .apiError(let msg):
            return msg
        case .unknown(_):
            return "Unexpected error"
        }
    }
}

extension Error {
    var message: String {
        if let buError = self as? BusinessError {
            return buError.message
        }
        
        return "Unexpected error"
    }
}
