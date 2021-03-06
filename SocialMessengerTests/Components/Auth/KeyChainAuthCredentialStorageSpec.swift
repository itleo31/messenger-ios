//
//  KeyChainAuthCredentialStorageSpec.swift
//  SocialMessengerTests
//
//  Created by Khanh Pham on 10/4/17.
//  Copyright © 2017 Khanh Pham. All rights reserved.
//

import Quick
import Nimble
@testable import SocialMessenger

class KeyChainAuthCredentialStorageSpec: QuickSpec {
    override func spec() {
        describe("KeyChainAuthCredentialStorageSpec") {
            
            var storage: KeyChainAuthCredentialStorage!
            
            beforeEach {
                storage = KeyChainAuthCredentialStorage()
            }
            
            afterEach {
                storage.save(nil)
            }
            
            it("shoud be able to save and load correctly") {
                let token = "sampletoken"
                storage.save(AuthCredential(token: token))
                
                var saved = storage.load()
                expect(saved).toNot(beNil())
                expect(saved?.token).to(equal(token))
                
                storage.save(nil)
                saved = storage.load()
                expect(saved).to(beNil())
            }
            
        }
    }
}
