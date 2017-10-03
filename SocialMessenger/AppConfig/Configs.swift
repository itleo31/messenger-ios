//
//  Configs.swift
//  SocialMessenger
//
//  Created by Khanh Pham on 9/1/17.
//  Copyright © 2017 Khanh Pham. All rights reserved.
//

import Foundation

struct Configs {
    #if DEBUG
    
    static let apiBaseURL = "https://fakeserver.com/api"
    static let isDebug = true
    
    #else
    
    static let apiBaseURL = "https://realserver.com/api"
    static let isDebug = false
    
    #endif
}
