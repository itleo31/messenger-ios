//
//  UtilSpec.swift
//  SocialMessengerTests
//
//  Created by Khanh Pham on 10/5/17.
//  Copyright © 2017 Khanh Pham. All rights reserved.
//

import Quick
import Nimble

@testable import SocialMessenger

class UtilSpec: QuickSpec {
    override func spec() {
        describe("UtilSpec") {
            it("delay should execute action") {
                var called = false
                delay(0.5, execute: {
                    called = true
                })
                
                expect(called).toEventually(beTrue(), timeout: 1)
            }
            
            it("UIImage should be able to init with color and size") {
                let image = UIImage(color: .red, size: CGSize(width: 10, height: 10))
                expect(image).notTo(beNil())
                let scale = UIScreen.main.scale
                expect(image?.size).to(equal(CGSize(width: 10 * scale, height: 10 * scale)))
            }
            
            it("UIColor be able to init with rgb values") {
                let color = UIColor(red: 70, green: 80, blue: 90)
                var red: CGFloat = 0
                var green: CGFloat = 0
                var blue: CGFloat = 0
                var alpha: CGFloat = 0
                color.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
                expect(red).to(equal(70.0/255))
                expect(green).to(equal(80.0/255))
                expect(blue).to(equal(90.0/255))
                expect(alpha).to(equal(255.0/255))
            }
            
            it("UIColor be able to init with rgb value") {
                let color = UIColor(rgb: 0xaabbcc) // 170, 187, 204
                var red: CGFloat = 0
                var green: CGFloat = 0
                var blue: CGFloat = 0
                var alpha: CGFloat = 0
                color.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
                expect(red).to(equal(170.0/255))
                expect(green).to(equal(187.0/255))
                expect(blue).to(equal(204.0/255))
                expect(alpha).to(equal(255.0/255))
            }
            
            describe("Optional string") {
                it("isNilOrEmpty should work properly") {
                    var string: String? = nil
                    expect(string.isNilOrEmpty).to(beTrue())
                    
                    string = ""
                    expect(string.isNilOrEmpty).to(beTrue())
                    
                    string = " "
                    expect(string.isNilOrEmpty).to(beFalse())
                    
                    string = "abc"
                    expect(string.isNilOrEmpty).to(beFalse())
                }
                
                it("notEmptyValue should work properly") {
                    var string: String? = nil
                    expect(string.notEmptyValue).to(beNil())
                    
                    string = ""
                    expect(string.notEmptyValue).to(beNil())
                    
                    string = " "
                    expect(string.notEmptyValue).toNot(beNil())
                    expect(string.notEmptyValue).toNot(beEmpty())
                    
                    string = "abc"
                    expect(string.notEmptyValue).toNot(beNil())
                    expect(string.notEmptyValue).toNot(beEmpty())
                }
                
                it("trimmed should work property") {
                    var string: String? = nil
                    expect(string.trimmed).to(equal(""))
                    
                    string = ""
                    expect(string.trimmed).to(equal(""))
                    
                    string = " "
                    expect(string.trimmed).to(equal(""))
                    
                    string = "a"
                    expect(string.trimmed).to(equal("a"))
                    
                    string = "  a "
                    expect(string.trimmed).to(equal("a"))
                }
                
                it("toEmptyIfNil should work properly") {
                    var string: String? = nil
                    expect(string.toEmptyIfNil).to(equal(""))
                    
                    string = ""
                    expect(string.toEmptyIfNil).to(equal(""))
                    
                    string = " "
                    expect(string.toEmptyIfNil).to(equal(" "))
                    
                    string = "a"
                    expect(string.toEmptyIfNil).to(equal("a"))
                }
            }
            
            describe("Optional collection") {
                it("isNilOrEmpty should work properly") {
                    var col: [Int]? = nil
                    expect(col.isNilOrEmpty).to(beTrue())
                    
                    col = []
                    expect(col.isNilOrEmpty).to(beTrue())
                    
                    col = [1]
                    expect(col.isNilOrEmpty).to(beFalse())
                }
                
                it("hasElement should work properly") {
                    var col: [Int]? = nil
                    expect(col.hasElements).to(beFalse())
                    
                    col = []
                    expect(col.hasElements).to(beFalse())
                    
                    col = [1]
                    expect(col.hasElements).to(beTrue())
                }
            }
            
            describe("String") {
                it("trimWhitespaces should work properly") {
                    var string: String = ""
                    expect(string.trimWhitespaces()).to(equal(""))
                    
                    string = " "
                    expect(string.trimWhitespaces()).to(equal(""))
                    
                    string = " a  "
                    expect(string.trimWhitespaces()).to(equal("a"))
                }
                
                it("stringByDeletingPathExtension should work properly") {
                    var string: String = "file.ext"
                    expect(string.stringByDeletingPathExtension).to(equal("file"))
                    
                    string = "file.abc.ext"
                    expect(string.stringByDeletingPathExtension).to(equal("file.abc"))
                    
                    string = "file"
                    expect(string.stringByDeletingPathExtension).to(equal("file"))
                }
                
                it("lastPathComponent should work properly") {
                    var string: String = "/tmp/scratch.tiff"
                    expect(string.lastPathComponent).to(equal("scratch.tiff"))
                    
                    string = "/tmp/scratch"
                    expect(string.lastPathComponent).to(equal("scratch"))
                    
                    string = "/tmp/"
                    expect(string.lastPathComponent).to(equal("tmp"))
                }
            }
            
            describe("NSRegularExpression") {
                it("matchesString should work properly") {
                    let emailRegex = regex("[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}")
                    
                    expect(emailRegex.matchesString("user@test.com")).to(beTrue())
                    expect(emailRegex.matchesString("notanemail")).to(beFalse())
                }
            }
            
            describe("others") {
                it("isIOS10Available") {
                    _ = isIOS10Available()
                    // Has no clue to to test this
                }
            }
        }
    }
}
