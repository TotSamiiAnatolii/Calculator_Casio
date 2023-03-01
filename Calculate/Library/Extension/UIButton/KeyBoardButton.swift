//
//  KeyBoardButton.swift
//  Calculate
//
//  Created by APPLE on 06.01.2023.
//

import UIKit

enum ShadowType: String {
    case innerShadow = "innerShadow"
    case topShadow = "topShadow"
    case bottomShadow = "bottomShadow"
}

struct ModelKeyBoardButton {
    let title: String
    let font: UIFont
    let backgroundColor: UIColor
    let titleColor: UIColor
}

final class KeyBoardButton: UIButton {
    
    private let innerShadow = CALayer()
    
    private var stateShadow: Bool = false
    
    public var typeButton: KeyBoardSymbol
    
    override var isHighlighted: Bool {
        didSet {
            switch isHighlighted {
            case true:
                setHiddenLayer(inner: false, top: true, bottom: true)
            case false:
                setHiddenLayer(inner: true, top: false, bottom: false)
            }
        }
    }
    
    private func setHiddenLayer(inner: Bool, top: Bool, bottom: Bool) {
        self.alpha = 1
        self.layer.sublayers?.forEach({ layer in
            switch layer.name {
            case ShadowType.innerShadow.rawValue:
                layer.isHidden = inner
            case ShadowType.topShadow.rawValue:
                layer.isHidden = top
            case ShadowType.bottomShadow.rawValue:
                layer.isHidden = bottom
            default:
                break
            }
        })
    }

    init(model: ModelKeyBoardButton, type: KeyBoardSymbol ) {
        self.typeButton = type
        super.init(frame: .zero)
        setConfiguration(model: model)
        self.layer.insertSublayer(innerShadow, at: 0)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setConfiguration(model: ModelKeyBoardButton) {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = model.backgroundColor
        self.contentMode = .scaleAspectFill
        self.setTitle(model.title, for: state)
        self.titleLabel?.font = model.font
        self.setTitleColor(model.titleColor, for: .normal)
        self.setTitleColor(model.titleColor.withAlphaComponent(0.7), for: .highlighted)
    }
    
    private func createShadowLayer(color: UIColor, offset: CGSize, opacity: Float, radius: CGFloat) -> CAShapeLayer {
        
        let shadowLayer = CAShapeLayer()
        shadowLayer.path = UIBezierPath(roundedRect: self.bounds, cornerRadius: self.frame.height / 2).cgPath
        shadowLayer.fillColor = self.backgroundColor?.cgColor
        shadowLayer.shadowPath = shadowLayer.path
        shadowLayer.masksToBounds = false
        shadowLayer.shadowColor = color.cgColor
        shadowLayer.shadowOpacity = opacity
        shadowLayer.shadowOffset = offset
        shadowLayer.shadowRadius = radius
        return shadowLayer
    }
    
    private func addDropShadow() {
        let topLayer = createShadowLayer(
            color: Colors.topShadow,
            offset: CGSize(width: -2, height: -4),
            opacity: 15,
            radius: 4)
        topLayer.name = ShadowType.topShadow.rawValue
        
        let bottomLayer = createShadowLayer(
            color: Colors.shadowKeyBoardButtonColor,
            offset: CGSize(width: 2, height: 4),
            opacity: 12,
            radius: 4)
        bottomLayer.name = ShadowType.bottomShadow.rawValue

        self.layer.insertSublayer(topLayer, at: 0)
        self.layer.insertSublayer(bottomLayer, at: 0)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.layer.cornerRadius = self.frame.height / 2
        
        if !self.stateShadow {
            addDropShadow()
            addInnerShadow()
            self.stateShadow = true
        }
    }
    
    private func addInnerShadow() {
        let radius = self.layer.cornerRadius
        innerShadow.name = ShadowType.innerShadow.rawValue
        innerShadow.isHidden = true
        innerShadow.backgroundColor = self.backgroundColor?.cgColor
        innerShadow.frame = self.bounds
       
        let path = UIBezierPath(roundedRect: innerShadow.bounds.insetBy(dx: 2, dy: 2), cornerRadius: radius)
        
        let cutout = UIBezierPath(roundedRect: innerShadow.bounds, cornerRadius: radius).reversing()
        path.append(cutout)
    
        innerShadow.shadowPath = path.cgPath
        innerShadow.shadowColor = UIColor.black.cgColor
        innerShadow.shadowOffset = CGSize(width: 0, height: 0)
        innerShadow.shadowOpacity = 3
        innerShadow.shadowRadius = 1
        innerShadow.cornerRadius = radius
    }
}


