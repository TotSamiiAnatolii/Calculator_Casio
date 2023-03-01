//
//  UIButton+.swift
//  Calculate
//
//  Created by USER on 05.01.2023.
//

import UIKit

extension UIButton {
    
    public typealias Func = () -> ()
    
    public func setTarget( method methodDown: Selector, target: Any, event: UIControl.Event ) -> Self {
        self.addTarget(target, action: methodDown.self, for: event)
        return self
    }
}
