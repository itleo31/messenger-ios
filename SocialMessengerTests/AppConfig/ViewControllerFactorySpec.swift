//
//  ViewControllerFactorySpec.swift
//  SocialMessengerTests
//
//  Created by Khanh Pham on 10/4/17.
//  Copyright © 2017 Khanh Pham. All rights reserved.
//

import Quick
import Nimble
@testable import SocialMessenger

class ViewControllerFactorySpec: QuickSpec {
    override func spec() {
        describe("ViewControllerFactorySpec") {
            it("should be able to create all needed view controllers") {
                let factory = ViewControllerFactory.shared
                
                expect(factory.homeViewController()).notTo(beNil())
                expect(factory.authNavigationController()).notTo(beNil())
            }
        }
    }
}
