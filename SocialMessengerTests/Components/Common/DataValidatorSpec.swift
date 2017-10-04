//
//  DataValidatorSpec.swift
//  SocialMessengerTests
//
//  Created by Khanh Pham on 10/4/17.
//  Copyright © 2017 Khanh Pham. All rights reserved.
//

import Quick
import Nimble

@testable import SocialMessenger

class DataValidatorSpec: QuickSpec {
    
    override func spec() {
        describe("DataValidatorSpec") {
            var validator: DataValidator!
            
            beforeEach {
                validator = DataValidator.shared
            }
            
            describe("email validation") {
                it("should return nil when email is valid") {
                    expect(validator.validate(email: "user@test.com")).to(beNil())
                }
                
                it("should return message when email is empty") {
                    expect(validator.validate(email: "")).toNot(beEmpty())
                }
                
                it("should return message when email is invalid format") {
                    expect(validator.validate(email: "abcdef")).toNot(beEmpty())
                }
            }
            
            describe("password validation") {
                it("should return nil when password has length >= 6") {
                    expect(validator.validate(password: "validpassword")).to(beNil())
                }
                
                it("should return message when password is empty") {
                    expect(validator.validate(password: "")).toNot(beEmpty())
                }
                
                it("should return message when password length is less than 6") {
                    expect(validator.validate(password: "1")).toNot(beEmpty())
                }
            }
            
            describe("name validation") {
                it("should return true when name is not empty") {
                    expect(validator.validate(name: "Joe")).to(beTrue())
                }
                
                it("should return false when name is empty") {
                    expect(validator.validate(name: "")).to(beFalse())
                }
            }
            
        }
    }
}
