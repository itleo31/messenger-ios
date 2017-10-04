//
//  AuthModelSpec.swift
//  SocialMessengerTests
//
//  Created by Khanh Pham on 10/4/17.
//  Copyright © 2017 Khanh Pham. All rights reserved.
//

import Quick
import Nimble
@testable import SocialMessenger

class AuthModelSpec: QuickSpec {
    override func spec() {
        describe("AuthCredentials") {
            it("should init successfully with token", closure: {
                let token = "sampletoken"
                let credentials = AuthCredential(token: token)
                
                expect(credentials.token).to(equal(token))
            })
        }
    }
}
