//
//  AppDelegateRootTransitionSpec.swift
//  SocialMessengerTests
//
//  Created by Khanh Pham on 10/5/17.
//  Copyright © 2017 Khanh Pham. All rights reserved.
//

import Quick
import Nimble

@testable import SocialMessenger

class AppDelegateRootTransitionSpec: QuickSpec {
    override func spec() {
        describe("AppDelegateRootTransitionSpec") {
            it("should switch rootViewController") {
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                let vc = UIViewController()
                appDelegate.switchRootViewController(vc, animated: false, completion: nil)
                expect(appDelegate.window?.rootViewController).toEventually(equal(vc))
            }
            
            it("should switch rootViewController when animated") {
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                let vc = UIViewController()
                appDelegate.switchRootViewController(vc, animated: true, completion: nil)
                expect(appDelegate.window?.rootViewController).toEventually(equal(vc))
            }
        }
    }
}
