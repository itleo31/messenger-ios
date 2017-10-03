//
//  AppDelegate.swift
//  SocialMessenger
//
//  Created by Khanh Pham on 8/31/17.
//  Copyright © 2017 Khanh Pham. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    let appComponents = AppComponents.shared
    let viewControllerFactory = ViewControllerFactory.shared

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        appComponents.setup()
        appComponents.authManager.application(application, didFinishLaunchingWithOptions: launchOptions)
        
        IQKeyboardManager.sharedManager().enable = true
        
        presentAppropriateViewController(animated: false)
        
        return true
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        return appComponents.authManager.application(app, open: url, options: options)
    }
    
    func presentAppropriateViewController(animated: Bool, completion: (() -> Void)? = nil) {
        let vc: UIViewController
        if appComponents.authManager.isAuthenticated {
            vc = viewControllerFactory.homeViewController()
        } else {
            vc = viewControllerFactory.logInViewController()
        }
        
        
        if let root = window?.rootViewController {
            if root.classForCoder == vc.classForCoder {
                completion?()
                return
            }
        }
        
        switchRootViewController(vc, animated: animated, completion: completion)
    }


}

