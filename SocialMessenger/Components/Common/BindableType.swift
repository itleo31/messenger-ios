//
//  BindableType.swift
//  JoltMate
//
//  Created by Khanh Pham on 8/21/17.
//  Copyright © 2017 Khanh Pham. All rights reserved.
//

import UIKit


protocol BindableType: class {
    associatedtype ViewModelType
    
    var viewModel: ViewModelType! { get set }
    
    func bindViewModel()
}

extension BindableType where Self: UIViewController {
    func bindViewModel(to model: Self.ViewModelType) {
        viewModel = model
        loadViewIfNeeded()
        bindViewModel()
    }
}

