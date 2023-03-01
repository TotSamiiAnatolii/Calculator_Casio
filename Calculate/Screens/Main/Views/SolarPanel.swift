//
//  SolarPanel.swift
//  Calculate
//
//  Created by USER on 05.01.2023.
//

import UIKit

final class SolarPanel: UIView {
    
    private let radius: CGFloat = 6
    
    private let innerShadow = CALayer()
    
    private let borderWidth: CGFloat = 0.7
    
    private let borderColor = Colors.borderDisplayColor
    
    private func setupView() {
        self.backgroundColor = Colors.solarPanelColor
        self.layer.cornerRadius = radius
        self.layer.borderWidth = borderWidth
        self.layer.borderColor = borderColor
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.addSublayer(innerShadow)
        setupView()
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        self.clipsToBounds = true
        
        innerShadow.frame = self.bounds
        let radius = self.layer.cornerRadius
        
        let path = UIBezierPath(roundedRect: innerShadow.bounds.insetBy(dx: 2, dy: 2), cornerRadius: radius)
        
        let cutout = UIBezierPath(roundedRect: innerShadow.bounds, cornerRadius: radius).reversing()
        
        path.append(cutout)
        innerShadow.shadowPath = path.cgPath
        
        innerShadow.masksToBounds = true
        
        innerShadow.shadowColor = Colors.shadowDisplayColor
        innerShadow.shadowOffset = CGSize(width: 0, height: 3)
        innerShadow.shadowOpacity = 5
        innerShadow.shadowRadius = 3
        innerShadow.cornerRadius = radius
        self.layer.addSublayer(innerShadow)
    }
}
