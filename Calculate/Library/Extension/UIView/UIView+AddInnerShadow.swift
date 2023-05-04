//
//  UIView+AddInnerShadow.swift
//  Calculate
//
//  Created by APPLE on 04.05.2023.
//

import UIKit

extension UIView {
    
    func addInnerShadow(layer: CALayer) {
        layer.frame = self.bounds
        let radius = self.layer.cornerRadius
        let path = UIBezierPath(roundedRect: layer.bounds.insetBy(dx: 2, dy: 2), cornerRadius: radius)
        let cutout = UIBezierPath(roundedRect: layer.bounds, cornerRadius: radius).reversing()
        path.append(cutout)
        
        layer.shadowPath = path.cgPath
        layer.masksToBounds = true
        layer.shadowColor = Colors.shadowDisplayColor
        layer.shadowOffset = CGSize(width: 0, height: 3)
        layer.shadowOpacity = 1
        layer.shadowRadius = 3
        layer.cornerRadius = radius
        self.layer.addSublayer(layer)
    }
}

