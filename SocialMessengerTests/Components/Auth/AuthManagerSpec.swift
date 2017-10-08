//
//  AuthManagerSpec.swift
//  SocialMessengerTests
//
//  Created by Khanh Pham on 10/8/17.
//  Copyright © 2017 Khanh Pham. All rights reserved.
//

import Quick
import Nimble

import RxSwift
import RxTest
import RxBlocking

@testable import SocialMessenger

class AuthManagerSpec: QuickSpec {
    override func spec() {
        describe("AuthManagerSpec") {
            var authManager: AuthManager!
            var authStorage: UserDefaultsAuthCredentialStorage!
            var apiService: MockAuthApiService!
            var disposeBag: DisposeBag!
            
            beforeEach {
                disposeBag = DisposeBag()
                authStorage = UserDefaultsAuthCredentialStorage()
                authStorage.save(nil)
                
                apiService = MockAuthApiService()
                authManager = AuthManager(authStorage: authStorage, authApiService: apiService)
            }
            
            it("isAuthenticated should return proper value") {
                expect(authManager.isAuthenticated).to(beFalse())
            }
            
            describe("signIn(withEmail:password:)") {
                context("success") {
                    beforeEach {
                        apiService.stub_signIn = .just(AuthCredential(token: "test"), dueTime: 0.25)
                    }
                    
                    it("should return event") {
                        let events = try! authManager.signIn(withEmail: "user@test.com", password: "password")
                            .toBlocking()
                            .toArray()
                        
                        expect(events).to(haveCount(1))
                    }
                    
                    it("should store authCredentials") {
                        authManager.signIn(withEmail: "user@test.com", password: "password")
                            .subscribe()
                            .disposed(by: disposeBag)
                        
                        expect(authManager.authCredential).toEventuallyNot(beNil())
                    }
                    
                    it("should emmit authStateChangedObservable") {
                        
                        var changed: Bool?
                        authManager.authStateChangedObservable
                            .subscribe(onNext: { event in
                                changed = event
                            })
                            .disposed(by: disposeBag)
                        
                        authManager.signIn(withEmail: "user@test.com", password: "password")
                            .subscribe()
                            .disposed(by: disposeBag)
                        
                        expect(changed).toEventually(beTrue())
                    }
                }
                
                context("failed") {
                    beforeEach {
                        apiService.stub_signIn = .error(BusinessError.unauthorized, dueTime: 0.25)
                    }
                    
                    it("should return error") {
                        var resError: Error?
                        authManager.signIn(withEmail: "user@test.com", password: "password")
                            .subscribe(onError: { error in
                                resError = error
                            })
                            .disposed(by: disposeBag)
                        
                        expect(resError).toEventuallyNot(beNil())
                    }
                }
            }
            
            describe("signUp(withEmail:password:)") {
                beforeEach {
                    apiService.stub_signIn = .just(AuthCredential(token: "test"), dueTime: 0.25)
                    apiService.stub_signUp = .just((), dueTime: 0.25)
                }
                
                context("success") {
                    it("should return event") {
                        let events = try! authManager.signUp(withEmail: "user@test.com", password: "password")
                            .toBlocking()
                            .toArray()
                        
                        expect(events).to(haveCount(1))
                    }
                    
                    it("should store authCredentials") {
                        authManager.signUp(withEmail: "user@test.com", password: "password")
                            .subscribe()
                            .disposed(by: disposeBag)
                        
                        expect(authManager.authCredential).toEventuallyNot(beNil())
                    }
                    
                    it("should emmit authStateChangedObservable") {
                        
                        var changed: Bool?
                        authManager.authStateChangedObservable
                            .subscribe(onNext: { event in
                                changed = event
                            })
                            .disposed(by: disposeBag)
                        
                        authManager.signUp(withEmail: "user@test.com", password: "password")
                            .subscribe()
                            .disposed(by: disposeBag)
                        
                        expect(changed).toEventually(beTrue())
                    }
                }
                
                context("failed") {
                    beforeEach {
                        apiService.stub_signUp = .error(BusinessError.apiError(message: "Test error"), dueTime: 0.25)
                    }
                    
                    it("should return error") {
                        var resError: Error?
                        authManager.signUp(withEmail: "user@test.com", password: "password")
                            .subscribe(onError: { error in
                                resError = error
                            })
                            .disposed(by: disposeBag)
                        
                        expect(resError).toEventuallyNot(beNil())
                    }
                }
            }
        }
    }
}

// MARK: - Helper

class MockAuthApiService: AuthApiServiceType {
    var stub_signUp: Observable<Void>?
    func signUp(withEmail email: String, password: String) -> Observable<Void> {
        return stub_signUp ?? .empty()
    }
    
    var stub_signIn: Observable<AuthCredential>?
    func signIn(withEmail email: String, password: String) -> Observable<AuthCredential> {
        return stub_signIn ?? .empty()
    }
}
