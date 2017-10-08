//
//  AppComponentsSpec.swift
//  SocialMessengerTests
//
//  Created by Khanh Pham on 10/4/17.
//  Copyright © 2017 Khanh Pham. All rights reserved.
//

import Quick
import Nimble
@testable import SocialMessenger

class AppComponentsSpec: QuickSpec {
    override func spec() {
        describe("AppComponentsSpec") {
            var appComponents: AppComponents!
            
            beforeEach {
                appComponents = AppComponents.shared
                appComponents.setup()
            }
            
            it("should setup its components correctly") {
                expect(appComponents.eventsLogger).notTo(beNil())
                expect(appComponents.authManager).notTo(beNil())
                expect(appComponents.loggerManager).notTo(beNil())
                expect(appComponents.dataValidator).notTo(beNil())
            }
        }
    }
}
