//
//  AuthApiServiceSpec.swift
//  SocialMessengerTests
//
//  Created by Khanh Pham on 10/8/17.
//  Copyright © 2017 Khanh Pham. All rights reserved.
//

import Nimble
import Quick
import Mockingjay
import RxTest
import RxBlocking
import RxSwift

@testable import SocialMessenger

class AuthApiServiceSpec: QuickSpec {
    override func spec() {
        
        describe("AuthApiServiceSpec") {
            var apiClient: ApiClient!
            var authApiService: AuthApiService!
            var disposeBag: DisposeBag!
            
            beforeEach {
                disposeBag = DisposeBag()
                apiClient = ApiClient(baseURL: "https://test.com/api")
                authApiService = AuthApiService(apiClient: apiClient)
            }
            
            describe("signUp(withEmail:password:)") {
                
                it("should return event when success") {
                    self.stub(everything, json(["result": "Success"]))
                    let events = try! authApiService.signUp(withEmail: "user@test.com", password: "password")
                        .toBlocking(timeout: 1)
                        .toArray()
                    
                    expect(events).to(haveCount(1))
                }
                it("should return error when failed") {
                    self.stub(everything, http(422))
                    var catchError: Error?
                    authApiService.signUp(withEmail: "user@test.com", password: "password")
                        .catchError({ (error) -> Observable<()> in
                            catchError = error
                            return .just(())
                        })
                        .subscribe()
                        .disposed(by: disposeBag)
                    
                    expect(catchError).toNotEventually(beNil())
                }
            }
            
            describe("signIn(withEmail:password:)") {
                
                it("should return event when success") {
                    self.stub(everything, json(["access_token": "testtoken"]))
                    let events = try! authApiService.signIn(withEmail: "user@test.com", password: "password")
                        .toBlocking(timeout: 1)
                        .toArray()
                    
                    expect(events).to(haveCount(1))
                    if let credential = events.first {
                        expect(credential.token).to(equal("testtoken"))
                    }
                }
                it("should return error when failed") {
                    self.stub(everything, http(422))
                    var catchError: Error?
                    authApiService.signIn(withEmail: "user@test.com", password: "password")
                        .subscribe(onError: { error in
                            catchError = error
                        })
                        .disposed(by: disposeBag)
                    
                    expect(catchError).toNotEventually(beNil())
                }
            }
        }
        
        
    }
}
