//
//  ApiClientSpec.swift
//  SocialMessengerTests
//
//  Created by Khanh Pham on 10/8/17.
//  Copyright © 2017 Khanh Pham. All rights reserved.
//

import Quick
import Nimble
import Mockingjay
import RxSwift
import RxBlocking
import RxTest
import SwiftyJSON


@testable import SocialMessenger

class ApiClientSpec: QuickSpec {
    override func spec() {
        describe("ApiClientSpec") {
            var apiClient: ApiClient!
            let baseURL = "https://test.com"
            var disposeBag: DisposeBag!
            
            beforeEach {
                apiClient = ApiClient(baseURL: baseURL)
                disposeBag = DisposeBag()
            }
            
            describe("requestJSON") {
                
                context("success") {
                
                    it("should got JSON object when server response valid JSON object") {
                        let stubJsonObj = ["status": "ok"]
                        self.stub(http(.get, uri: "/test"), json(stubJsonObj))
                        
                        let res = try! apiClient.requestJSON(.get, path: "/test")
                            .toBlocking(timeout: 1)
                            .toArray()
                        
                        expect(res.count).to(equal(1))
                        expect(res.first).to(equal(JSON(stubJsonObj)))
                    }
                    
                    it("should got JSON array when server response valid JSON array") {
                        let obj1 = ["name": "obj1"]
                        let obj2 = ["name": "obj2"]
                        let stubJsonObj = [obj1, obj2]
                        self.stub(http(.get, uri: "/test"), json(stubJsonObj))
                        
                        let res = try! apiClient.requestJSON(.get, path: "/test")
                            .toBlocking(timeout: 1)
                            .toArray()
                        
                        expect(res.count).to(equal(1))
                        expect(res.first).to(equal(JSON(stubJsonObj)))
                    }
                
                }
                
                context("failed") {
                    it("should got error when server response error") {
                        self.stub(http(.get, uri: "/test"), http(401))
                        
                        var resError: Error?
                        apiClient.requestJSON(.get, path: "/test")
                            .catchError({ (err) -> Observable<JSON> in
                                resError = err
                                return .empty()
                            })
                            .subscribe()
                            .disposed(by: disposeBag)
                        
                        expect(resError).toNotEventually(beNil())
                    }
                }
            }
        }
    }
}

