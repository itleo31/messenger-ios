//
//  RxExt.swift
//  JoltMate
//
//  Created by Khanh Pham on 8/19/17.
//  Copyright © 2017 Khanh Pham. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

extension ObservableType {
    
    public func observeOnMain() -> RxSwift.Observable<Self.E> {
        return observeOn(MainScheduler.instance)
    }
    
    public func ignoreValue() -> Observable<Void> {
        return map { _ in () }
    }
    
    public func mergeProcessing(variable: Variable<Bool?>) -> RxSwift.Observable<Self.E> {
        return self
            .do(onError: { _ in variable.value = false }
                , onCompleted: { variable.value = false }
                , onSubscribed: { variable.value = true })
    }
    
    public static func just(_ element: Self.E, dueTime: RxTimeInterval) -> Observable<Self.E> {
        return Observable<Int>.timer(dueTime, scheduler: MainScheduler.instance)
            .map { _ in element }
    }
    
    public static func just(_ element: Self.E, dueTime: RxTimeInterval, scheduler: SchedulerType) -> Observable<Self.E> {
        return Observable<Int>.timer(dueTime, scheduler: scheduler)
            .map { _ in element }
    }
    
    public static func error(_ error: Error, dueTime: RxTimeInterval) -> Observable<Self.E> {
        return Observable<Int>.timer(dueTime, scheduler: MainScheduler.instance)
            .flatMap { _ in Observable<Self.E>.error(error) }
    }
    
    
}

extension ObserverType {
    public func onNextAndCompleted(_ element: Self.E) {
        onNext(element)
        onCompleted()
    }
}


