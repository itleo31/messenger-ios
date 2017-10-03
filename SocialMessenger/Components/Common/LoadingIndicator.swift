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
    
    private let syncQueue = DispatchQueue(label: "LoadingIndicatorSerial")
    
    private var _count: Int = 0
    private var count: Int {
        get {
            var rs: Int = 0
            syncQueue.sync {
                rs = _count
            }
            return rs
        } set {
            syncQueue.sync {
                _count = newValue
            }
        }
    }
    
    func show(color: UIColor? = .clear) {
        count = count + 1
        
        if count == 1 {
            NVActivityIndicatorPresenter.sharedInstance.startAnimating(ActivityData(size: CGSize(width: 30, height: 30), color: color, backgroundColor: .clear))
            UIApplication.shared.isNetworkActivityIndicatorVisible = true
        }
    }
    
    func pop() {
        if count > 0 {
            count = count - 1
            if count == 0 {
                NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
            }
        }
    }
}

private var processCount = 0

let loadingSize = CGSize(width: 30, height: 30)
let loadingColor = UIColor(rgb: 0xCCCCCC)

extension UIViewController {
    func executeAnimated<E>(observable: Observable<E>, color: UIColor? = loadingColor) -> Observable<E> {
        
        let shared = observable.share()
        LoadingIndicator.shared.show(color: color)
        
        _ = shared.observeOnMain()
            .subscribe(onDisposed: { _ in
                LoadingIndicator.shared.pop()
            })
        
        
        return shared.observeOnMain()
    }
    
    func bindAnimateWith(variable: Variable<Bool?>, color: UIColor? = loadingColor) -> Disposable {
        
        return variable.asObservable()
            .filter { $0 != nil }
            .map { $0 ?? false }
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
