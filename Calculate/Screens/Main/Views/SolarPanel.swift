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

    private func setupView() {
        self.clipsToBounds = true
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = Colors.solarPanelColor
        self.layer.cornerRadius = radius
        self.layer.borderWidth = borderWidth
        self.layer.borderColor = Colors.borderDisplayColor
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.addSublayer(innerShadow)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        self.addInnerShadow(layer: innerShadow)

    }
}
