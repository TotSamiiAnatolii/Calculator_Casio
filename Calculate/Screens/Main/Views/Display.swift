//
//  Display.swift
//  Calculate
//
//  Created by USER on 05.01.2023.
//

import UIKit

final class Display: UIView {
    
    private let radius: CGFloat = 10
    
    private let innerShadow = CALayer()
  
    private let borderWidth: CGFloat = 0.7
    
    private let borderColor = Colors.borderDisplayColor
    
    private func setupView() {
        self.layer.cornerRadius = radius
        self.layer.borderWidth = borderWidth
        self.layer.borderColor = borderColor
    }
    
    public let textField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.textAlignment = .right
        textField.font = Fonts.displayFont
        textField.backgroundColor = Colors.displayColor
        return textField
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = Colors.displayColor
        textField.insertText("0")
        setupView()
        self.translatesAutoresizingMaskIntoConstraints = false
        
        setViewHierarhies()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setViewHierarhies() {
        self.addSubview(textField)
        self.layer.addSublayer(innerShadow)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: self.topAnchor),
            textField.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10),
            textField.leftAnchor.constraint(equalTo: self.leftAnchor),
            textField.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
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
    }
}
extension Display: DisplayManage {
    
    func setValue(value: String) {
        self.textField.insertText(value)
        
        if value == "-0" {
            return
        }
        guard let currentText = textField.text else {
            return
        }
        
        if currentText.range(of: Locale.current.decimalSeparator ?? ".") == nil {
            self.textField.text? = currentText.convertTextInDouble().formatterFrom
        }
        
        let newPosition = textField.endOfDocument
        textField.selectedTextRange = textField.textRange(from: newPosition, to: newPosition)
    }
    
    func delete() {
        self.textField.text?.removeAll()
    }
    
    func clear() {
        self.textField.text?.removeAll()
        self.textField.insertText("0")
    }
}
