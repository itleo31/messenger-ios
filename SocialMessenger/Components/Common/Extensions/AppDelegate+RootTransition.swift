//
//  AppDelegate+RootTransition.swift
//  JoltMate
//
//  Created by Khanh Pham on 8/19/17.
//  Copyright © 2017 Khanh Pham. All rights reserved.
//

import UIKit

extension AppDelegate {
    
    /**
     Change rootViewController with animation
     */
    func switchRootViewController(_ rootViewController: UIViewController, animated: Bool, completion: (() -> Void)?) {
        if animated && self.window!.rootViewController != nil {
            
            let snapshot = window!.snapshotView(afterScreenUpdates: true) ?? UIView()
            rootViewController.view.addSubview(snapshot)
            window!.rootViewController = rootViewController
            UIView.animate(withDuration: 0.5, animations: { () -> Void in
                snapshot.layer.opacity = 0;
                snapshot.layer.transform = CATransform3DMakeScale(1.5, 1.5, 1.5);
            }, completion: { (finished) -> Void in
                snapshot.removeFromSuperview()
                completion?()
            })
        } else {
            window!.rootViewController = rootViewController
            completion?()
        }
    }
}
