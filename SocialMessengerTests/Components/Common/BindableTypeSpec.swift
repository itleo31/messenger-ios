//
//  BindableTypeSpec.swift
//  SocialMessengerTests
//
//  Created by Khanh Pham on 10/4/17.
//  Copyright © 2017 Khanh Pham. All rights reserved.
//

import Quick
import Nimble
@testable import SocialMessenger

class SampleBindableViewController: UIViewController, BindableType {
    typealias ViewModelType = NSObject
    var viewModel: NSObject!
    
    func bindViewModel() {
        bindViewModelCalled = true
    }
    
    private(set) var bindViewModelCalled = false
}

class BindableTypeSpec: QuickSpec {
    override func spec() {
        describe("BindableTypeSpec") {
            it("should call bindViewModel") {
                let sample = SampleBindableViewController()
                sample.bindViewModel(to: NSObject())
                
                expect(sample.bindViewModelCalled).to(beTrue())
            }
        }
    }
}

