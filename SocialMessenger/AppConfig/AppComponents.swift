//
//  AppComponents.swift
//  SocialMessenger
//
//  Created by Khanh Pham on 10/3/17.
//  Copyright © 2017 Khanh Pham. All rights reserved.
//

import Foundation
import Swinject

class AppComponents {
    
    static let shared = AppComponents()
    
    private let container: Container
    
    private init() {
        container = Container()
    }
    
    func setup() {
        registerComponents()
        
        loggerManager.configure()
    }
    
    lazy var eventsLogger: EventsLogging = { this in
        return this.container.resolve(EventsLogging.self)!
    }(self)
    
    lazy var authManager: AuthManaging = { this in
        return this.container.resolve(AuthManaging.self)!
    }(self)
    
    lazy var loggerManager: LoggerManager = {
        return LoggerManager.shared
    }()
    
    private func registerComponents() {
        container.register(AuthCredentialStorageType.self) { _ in UserDefaultsAuthCredentialStorage() }
        
        container.register(AuthManaging.self) { (resolver) in
            return AuthManager(authStorage: resolver.resolve(AuthCredentialStorageType.self)!)
        }
        
        container.register(EventsLogging.self) { _ in EventsLogger() }
    }
    
}
