//
//  UIKitRxSpec.swift
//  SocialMessengerTests
//
//  Created by Khanh Pham on 10/4/17.
//  Copyright © 2017 Khanh Pham. All rights reserved.
//

import Quick
import Nimble
import RxCocoa
import RxSwift
import RxTest
import XCTest

@testable import SocialMessenger

class UIKitRxSpec: QuickSpec {
    override func spec() {
        describe("UIKitRxSpec") {
            describe("UIViewController") {
                
                var testScheduler: TestScheduler!
                var disposeBag: DisposeBag!
                var vc: UIViewController!
                
                beforeEach {
                    vc = UIViewController()
                    testScheduler = TestScheduler(initialClock: 0)
                    disposeBag = DisposeBag()
                }
                
                it("can observe viewDidLoad") {
                    let observable = vc.rx.viewDidLoad
                    
                    let observer = testScheduler.createObserver(Bool.self)
                    observable.map { true }.subscribe(observer)
                        .disposed(by: disposeBag)
                    
                    testScheduler.scheduleAt(300, action: {
                        vc.viewDidLoad()
                    })
                    
                    testScheduler.start()
                    
                    XCTAssertEqual(observer.events, [next(300, true)])
                }
                
                it("can observe viewDidAppear") {
                    let observable = vc.rx.viewDidAppear
                    
                    let observer = testScheduler.createObserver(Bool.self)
                    observable.subscribe(observer)
                        .disposed(by: disposeBag)
                    
                    testScheduler.scheduleAt(300, action: {
                        vc.viewDidAppear(true)
                    })
                    
                    testScheduler.start()
                    
                    XCTAssertEqual(observer.events, [next(300, true)])
                }
                
                it("can observe viewWillAppear") {
                    let observable = vc.rx.viewWillAppear
                    
                    let observer = testScheduler.createObserver(Bool.self)
                    observable.subscribe(observer)
                        .disposed(by: disposeBag)
                    
                    testScheduler.scheduleAt(300, action: {
                        vc.viewWillAppear(true)
                    })
                    
                    testScheduler.start()
                    
                    XCTAssertEqual(observer.events, [next(300, true)])
                }
            }
            
            describe("UIControl") {
                var disposeBag: DisposeBag!
                
                beforeEach {
                    disposeBag = DisposeBag()
                }
                
                it("can chainEditingDidEndOnExit property") {
                    let tf1 = UITextField()
                    let tf2 = UITextField()
                    UIControl.chainEditingDidEndOnExit(controls: [tf1, tf2]).disposed(by: disposeBag)
                    tf1.becomeFirstResponder()
                    tf1.sendActions(for: .editingDidEndOnExit)
                    
//                    expect(tf2.isFirstResponder).toEventually(beTrue(), timeout: 2)
                }
            }
            
            describe("UINavigationController") {
                
                var testScheduler: TestScheduler!
                var disposeBag: DisposeBag!
                var navVC: UINavigationController!
                var vc1: UIViewController!
                var vc2: UIViewController!
                
                beforeEach {
                    vc1 = UIViewController()
                    vc2 = UIViewController()
                    navVC = UINavigationController()
                    testScheduler = TestScheduler(initialClock: 0)
                    disposeBag = DisposeBag()
                }
                
                it("can pushViewController properly") {
                    navVC.setViewControllers([vc1], animated: false)
                    
                    let observable = navVC.rx.pushViewController(vc2, animated: false)
                    
                    let observer = testScheduler.createObserver(Bool.self)
                    
                    testScheduler.scheduleAt(300, action: {
                        observable.map { true }.subscribe(observer)
                            .disposed(by: disposeBag)
                    })
                    
                    testScheduler.start()
                    
                    XCTAssertEqual(observer.events, [next(300, true), completed(300)])
                }
                
                it("can popViewController properly") {
                    navVC.setViewControllers([vc1, vc2], animated: false)
                    
                    let observable = navVC.rx.popViewController(animated: false)
                    
                    let observer = testScheduler.createObserver(Bool.self)
                    
                    testScheduler.scheduleAt(300, action: {
                        observable.map { _ in true }.subscribe(observer)
                            .disposed(by: disposeBag)
                    })
                    
                    testScheduler.start()
                    
                    XCTAssertEqual(observer.events, [next(300, true), completed(300)])
                }
                
                it("can popToViewController properly") {
                    navVC.setViewControllers([vc1, vc2], animated: false)
                    
                    let observable = navVC.rx.popToViewController(vc1, animated: false)
                    
                    let observer = testScheduler.createObserver(Bool.self)
                    
                    testScheduler.scheduleAt(300, action: {
                        observable.map { _ in true }.subscribe(observer)
                            .disposed(by: disposeBag)
                    })
                    
                    testScheduler.start()
                    
                    XCTAssertEqual(observer.events, [next(300, true), completed(300)])
                }
                
                it("can popToRootViewController properly") {
                    navVC.setViewControllers([vc1, vc2], animated: false)
                    
                    let observable = navVC.rx.popToRootViewController(animated: false)
                    
                    let observer = testScheduler.createObserver(Bool.self)
                    
                    testScheduler.scheduleAt(300, action: {
                        observable.map { _ in true }.subscribe(observer)
                            .disposed(by: disposeBag)
                    })
                    
                    testScheduler.start()
                    
                    XCTAssertEqual(observer.events, [next(300, true), completed(300)])
                }
                
            }
        }
    }
}
