//
//  ViewControllerFactory.swift
//  SocialMessenger
//
//  Created by Khanh Pham on 9/1/17.
//  Copyright © 2017 Khanh Pham. All rights reserved.
//

import UIKit
//import Swinject
//import SwinjectStoryboard

class ViewControllerFactory {
    
    static let shared = ViewControllerFactory()
    
    private init() { }
    
    func logInViewController() -> LogInViewController {
        return authStoryboard.instantiateViewController(withIdentifier: "LogInViewController") as! LogInViewController
    }
    
    func homeViewController() -> HomeViewController {
        return homeStoryboard.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
    }
    
    lazy private var authStoryboard: UIStoryboard = {
        return UIStoryboard(name: "Auth", bundle: nil)
    }()
    
    lazy private var homeStoryboard: UIStoryboard = {
        return UIStoryboard(name: "Home", bundle: nil)
    }()
}
