//
//  UINavigationController.swift
//  veda
//
//  Created by Евгений Петрукович on 1/31/26.
//

import SwiftUI

extension UINavigationController: @retroactive UIGestureRecognizerDelegate {
    override open func viewDidLoad() {
        super.viewDidLoad()
        
        interactivePopGestureRecognizer?.isEnabled = false
        
        if let target = interactivePopGestureRecognizer?.delegate {
            let action = NSSelectorFromString("handleNavigationTransition:")
            let fullScreenPan = UIPanGestureRecognizer(target: target, action: action)
            fullScreenPan.maximumNumberOfTouches = 1
            fullScreenPan.delegate = self
            view.addGestureRecognizer(fullScreenPan)
        }
    }

    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        if viewControllers.count <= 1 {
            return false
        }
        
        let isTransitioning = (value(forKey: "_isTransitioning") as? Bool) ?? false
        if isTransitioning {
            return false
        }
        
        if let pan = gestureRecognizer as? UIPanGestureRecognizer {
            let translation = pan.translation(in: gestureRecognizer.view)
            if translation.x <= 0 {
                return false
            }
        }
        
        return true
    }
    
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer,
                                  shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        if let scrollView = otherGestureRecognizer.view as? UIScrollView {
            return scrollView.contentOffset.x <= 0
        }
        return false
    }
}
