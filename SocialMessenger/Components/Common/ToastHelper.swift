//
//  ToastHelper.swift
//  SocialMessenger
//
//  Created by Khanh Pham on 10/5/17.
//  Copyright © 2017 Khanh Pham. All rights reserved.
//

import UIKit
import Toaster
import RxSwift

class ToastHelper {
    
    static func bindWith(_ observable: Observable<String>) -> Disposable {
        return observable
            .shareReplay(1)
            .observeOnMain()
            .filter { !$0.isEmpty }
            .subscribe(onNext: { val in
                let toast = Toast(text: val)
                toast.show()
            })
    }
}
