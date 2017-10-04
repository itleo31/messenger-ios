//
//  EventsLoggerSpec.swift
//  SocialMessengerTests
//
//  Created by Khanh Pham on 10/4/17.
//  Copyright © 2017 Khanh Pham. All rights reserved.
//

import Quick
import Nimble

@testable import SocialMessenger

class EventsLoggerSpec: QuickSpec {
    override func spec() {
        describe("EventsLoggerSpec") {
            it ("should able to log without error") {
                let logger = EventsLogger()
                logger.activate(UIApplication.shared)
            }
        }
    }
}
