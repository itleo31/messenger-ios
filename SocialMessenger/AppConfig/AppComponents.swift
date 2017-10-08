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
    
    lazy var apiClient: ApiClientType = { this in
        return this.container.resolve(ApiClientType.self)!
    }(self)
    
    lazy var authApiService: AuthApiServiceType = { this in
        return this.container.resolve(AuthApiServiceType.self)!
    }(self)
    
    lazy var authManager: AuthManaging = { this in
        return this.container.resolve(AuthManaging.self)!
    }(self)
    
    lazy var loggerManager: LoggerManager = {
        return LoggerManager.shared
    }()
    
    lazy var dataValidator: DataValidator = {
        return DataValidator.shared
    }()
    
    private func registerComponents() {
        container.register(AuthCredentialStorageType.self) { _ in
            if Configs.isDebug {
                return UserDefaultsAuthCredentialStorage()
            } else {
                return KeyChainAuthCredentialStorage()
            }
        }
        
        container.register(ApiClientType.self) { _ in
            return ApiClient(baseURL: Configs.apiBaseURL)
        }
        
        container.register(AuthApiServiceType.self) { (resolver) in
            return AuthApiService(apiClient: resolver.resolve(ApiClientType.self)!)
        }
        
        container.register(AuthManaging.self) { (resolver) in
            return AuthManager(authStorage: resolver.resolve(AuthCredentialStorageType.self)!, authApiService: resolver.resolve(AuthApiServiceType.self)!)
        }
        
        container.register(EventsLogging.self) { _ in EventsLogger() }
    }
    
}
