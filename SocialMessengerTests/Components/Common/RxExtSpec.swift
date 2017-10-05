//
//  RxExtSpec.swift
//  SocialMessengerTests
//
//  Created by Khanh Pham on 10/4/17.
//  Copyright © 2017 Khanh Pham. All rights reserved.
//

import Quick
import Nimble

import RxSwift
import RxCocoa
import RxTest
import RxBlocking

import XCTest

@testable import SocialMessenger

class RxExtSpec: QuickSpec {
    override func spec() {
        describe("RxExtSpec") {
            var testScheduler: TestScheduler!
            
            beforeEach {
                testScheduler = TestScheduler(initialClock: 0)
            }
            
            it("ignoreValue() should receive void events") {
                let observable = testScheduler.createHotObservable([next(250, 1), next(300, 2), completed(500)])
                
                let res = testScheduler.start { observable.ignoreValue().map { true } }
                
                let correctEvents: [Recorded<Event<Bool>>] = [
                    next(250, true),
                    next(300, true),
                    completed(500)
                ]
                
                XCTAssertEqual(res.events, correctEvents)
            }
            
            it("just(_:dueTime:) should receive events at correct time") {
                let observable = Observable<Int>.just(1, dueTime: 300, scheduler: testScheduler)
                
                let res = testScheduler.start { observable.asObservable() }
                
                let correctEvents: [Recorded<Event<Int>>] = [
                    next(500, 1),
                    completed(500)
                ]
                
                XCTAssertEqual(res.events, correctEvents)
            }
            
            it("error(_:dueTime:) should receive events at correct time") {
                let err = NSError(domain: "test", code: 1, userInfo: nil)
                let observable = Observable<Int>.error(err, dueTime: 300, scheduler: testScheduler)
                
                let res = testScheduler.start { observable.asObservable() }
                
                let correctEvents: [Recorded<Event<Int>>] = [
                    error(500, err)
                ]
                
                XCTAssertEqual(res.events, correctEvents)
            }
            
            it("onNextAndCompleted(_:) should send next and completed events") {
                let observable = Observable<Int>.create({ (observer) -> Disposable in
                    observer.onNext(5)
                    observer.onNextAndCompleted(1)
                    return Disposables.create()
                })
                
                let rs = try! observable.toBlocking().toArray()
                
                expect(rs).to(equal([5, 1]))
            }
        }
    }
}
