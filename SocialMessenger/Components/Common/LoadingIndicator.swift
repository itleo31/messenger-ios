//
//  LoadingIndicator.swift
//  JoltMate
//
//  Created by Khanh Pham on 8/22/17.
//  Copyright © 2017 Khanh Pham. All rights reserved.
//

import Foundation
import NVActivityIndicatorView
import RxCocoa
import RxSwift


class LoadingIndicator {
    
    static let shared = LoadingIndicator()
    
    func show(color: UIColor? = .clear) {
        NVActivityIndicatorPresenter.sharedInstance.startAnimating(ActivityData(size: CGSize(width: 30, height: 30), color: color, backgroundColor: .clear))
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    func pop() {
        NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
}


let loadingSize = CGSize(width: 30, height: 30)
let loadingColor = UIColor(rgb: 0xCCCCCC)

extension UIViewController {
    func bindAnimateWith(variable: Variable<Bool>, color: UIColor? = loadingColor) -> Disposable {
        
        return variable.asObservable()
            .observeOnMain()
            .subscribe(onNext: { (loading) in
                if loading {
                    LoadingIndicator.shared.show(color: color)
                } else {
                    LoadingIndicator.shared.pop()
                }
            })
    }
}
