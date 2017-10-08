//
//  UIKit+Rx.swift
//  JoltMate
//
//  Created by Khanh Pham on 8/22/17.
//  Copyright © 2017 Khanh Pham. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

    
extension Reactive where Base: UIViewController {
    
    var viewDidLoad: Observable<Void> {
        return self.sentMessage(#selector(Base.viewDidLoad)).map { _ in () }
    }
    
    var viewDidAppear: Observable<Bool> {
        return self.sentMessage(#selector(Base.viewDidAppear(_:))).map { args in
            let animated = (args.first as? Bool) ?? false
            return animated
        }
    }
    
    var viewWillAppear: Observable<Bool> {
        return self.sentMessage(#selector(Base.viewWillAppear(_:))).map { args in
            let animated = (args.first as? Bool) ?? false
            return animated
        }
    }
}

extension UIControl {
    static func chainEditingDidEndOnExit(controls: [UIControl]) -> Disposable {
        assert(controls.count > 1)
        var disposables: [Disposable] = []
        controls.enumerated().forEach { (ele) in
            if ele.offset == controls.count - 1 {
                return
            }
            
            disposables.append(ele.element.rx.controlEvent(.editingDidEndOnExit)
                .asObservable()
                .subscribe(onNext: { (_) in
                    controls[ele.offset + 1].becomeFirstResponder()
                }))
        }
        
        return Disposables.create(disposables)
    }
}

extension Reactive where Base: UINavigationController {
    func pushViewController(_ viewController: UIViewController, animated: Bool) -> Observable<Void> {
        return Observable.create({[weak controller = base] (observer) -> Disposable in
            guard let navController = controller else {
                observer.onCompleted()
                return Disposables.create()
            }
            
            navController.pushViewController(viewController, animated: animated)
            observer.onNextAndCompleted(())
            return Disposables.create()
        })
        
    }
    
    func popViewController(animated: Bool) -> Observable<UIViewController?> {
        return Observable.create({[weak controller = base] (observer) -> Disposable in
            guard let navController = controller else {
                observer.onCompleted()
                return Disposables.create()
            }
            
            let vc = navController.popViewController(animated: animated)
            observer.onNextAndCompleted(vc)
            return Disposables.create()
        })
        
    }
    
    func popToViewController(_ viewController: UIViewController, animated: Bool) -> Observable<[UIViewController]?> {
        return Observable.create({[weak controller = base] (observer) -> Disposable in
            guard let navController = controller else {
                observer.onCompleted()
                return Disposables.create()
            }
            
            let vc = navController.popToViewController(viewController, animated: animated)
            observer.onNextAndCompleted(vc)
            return Disposables.create()
        })
    }
    
    func popToRootViewController(animated: Bool) -> Observable<[UIViewController]?> {
        return Observable.create({[weak controller = base] (observer) -> Disposable in
            guard let navController = controller else {
                observer.onCompleted()
                return Disposables.create()
            }
            
            let vc = navController.popToRootViewController(animated: animated)
            observer.onNextAndCompleted(vc)
            return Disposables.create()
        })
    }
    
    
}

extension Variable {
    func bidirectionalBind(with property: ControlProperty<Element?>) -> Disposable {
        let varToProp = self.asDriver()
            .asDriver()
            .asObservable()
            .bind(to: property)
        
        let propToVar = property
            .subscribe(
                onNext: { [weak self] val in
                    guard let variable = self, let value = val else {
                        return
                    }
                    
                    variable.value = value
                },
                onCompleted: {
                    varToProp.dispose()
            }
        )
        
        return CompositeDisposable(varToProp, propToVar)
    }
}
