//
//  LoadingIndicatorSpec.swift
//  SocialMessengerTests
//
//  Created by Khanh Pham on 10/4/17.
//  Copyright © 2017 Khanh Pham. All rights reserved.
//

import Quick
import Nimble

@testable import SocialMessenger

class LoadingIndicatorSpec: QuickSpec {
    override func spec() {
        describe("LoadingIndicatorSpec") {
            var indicator: LoadingIndicator!
            
            beforeEach() {
                indicator = LoadingIndicator.shared
            }
            
            it("should be able to show") {
                indicator.show()
                indicator.show(color: UIColor.blue)
            }
            
            it("should be able to pop") {
                indicator.pop()
            }
        }
    }
}
