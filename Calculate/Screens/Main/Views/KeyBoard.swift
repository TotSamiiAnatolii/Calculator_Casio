//
//  KeyBoard.swift
//  Calculate
//
//  Created by USER on 05.01.2023.
//

import UIKit

enum KeyBoardSymbol: String, CaseIterable {
    case ac = "A/C"
    case plusMinus = "+/-"
    case percent = "%"
    case divide = "÷"
    case seven = "7"
    case eight = "8"
    case nine = "9"
    case multiply = "×"
    case four = "4"
    case five = "5"
    case six = "6"
    case minus = "−"
    case one = "1"
    case two = "2"
    case three = "3"
    case plus = "+"
    case zero = "0"
    case decimal
    case sum = "="
}

final class KeyBoard: UIView {
    
    private var buttons: [UIButton] = []
        
    weak var delegate: KeyBoardDelegate?
    
    private let buttonsInRow = 4
    
    private let containerStackView = UIStackView()
        .myStyleStack(
            spacing: 17,
            alignment: .fill,
            axis: .horizontal,
            distribution: .fillProportionally,
            userInteraction: true)
    
    private let lastStackView = UIStackView()
        .myStyleStack(
            spacing: 17,
            alignment: .fill,
            axis: .horizontal,
            distribution: .fillEqually,
            userInteraction: true)
    
    private let zeroStackView = UIStackView()
        .myStyleStack(
            spacing: 0,
            alignment: .fill,
            axis: .horizontal,
            distribution: .fill,
            userInteraction: true)
    
    private lazy var decimalSeparatorButton = KeyBoardButton(model: ModelKeyBoardButton(
        title: Locale.current.decimalSeparator ?? ".",
        font: Fonts.numbers,
        backgroundColor: Colors.bodyColor,
        titleColor: .black), type: .decimal)
        .setTarget(
            method: #selector(buttonAction),
            target: self,
            event: .touchUpInside)
    
    private lazy var zeroButton = KeyBoardButton(model: ModelKeyBoardButton(
        title: KeyBoardSymbol.zero.rawValue,
        font: Fonts.numbers,
        backgroundColor: Colors.bodyColor,
        titleColor: .black), type: .zero)
        .setTarget(
            method: #selector(buttonAction),
            target: self,
            event: .touchUpInside)
    
    private lazy var sumButton = KeyBoardButton(model: ModelKeyBoardButton(
        title: KeyBoardSymbol.sum.rawValue,
        font: Fonts.sing,
        backgroundColor: Colors.orangeColor,
        titleColor: .black), type: .sum)
        .setTarget(
            method: #selector(buttonAction),
            target: self,
            event: .touchUpInside)
    
    private let mainStackView = UIStackView()
        .myStyleStack(
            spacing: 17,
            alignment: .fill,
            axis: .vertical,
            distribution: .fillEqually,
            userInteraction: true)
        .setLayoutMargins(top: 10, left: 12, bottom: 10, right: 12)
    
    private func createButton(type: KeyBoardSymbol) -> UIButton {
        let button: KeyBoardButton
        
        let title = type.rawValue

        switch type {
        case .multiply, .plus, .minus, .divide:
            button = KeyBoardButton(model: ModelKeyBoardButton(
                title: title,
                font: Fonts.sing,
                backgroundColor: Colors.bodyColor,
                titleColor: .black), type: type)
            button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
            
        case .percent:
            button = KeyBoardButton(model: ModelKeyBoardButton(
                title: title,
                font: Fonts.percent,
                backgroundColor: Colors.bodyColor,
                titleColor: .black), type: type)
            button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
            
        case .plusMinus:
            button = KeyBoardButton(model: ModelKeyBoardButton(
                title: title,
                font: Fonts.plusMinus,
                backgroundColor: Colors.bodyColor,
                titleColor: .black), type: type)
            button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
            
        case .ac:
            button = KeyBoardButton(model: ModelKeyBoardButton(
                title: title,
                font: Fonts.ac,
                backgroundColor: Colors.bodyColor,
                titleColor: .black), type: type)
            button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
     
        default:
            button = KeyBoardButton(model: ModelKeyBoardButton(
                title: title,
                font: Fonts.numbers,
                backgroundColor: Colors.bodyColor,
                titleColor: .black), type: type)
            button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        }
        return button
    }
    
    private func createStackViewNumber(element: UIButton) {
        
        if buttons.count < buttonsInRow {
            buttons.append(element)
        } else {
            
            let stackViewAnswer = UIStackView()
                .myStyleStack(
                    spacing: 17,
                    alignment: .fill,
                    axis: .horizontal,
                    distribution: .fillEqually,
                    userInteraction: true)
            
            buttons.forEach { button in
                stackViewAnswer.addArrangedSubview(button)
            }
            
            mainStackView.addArrangedSubview(stackViewAnswer)
            buttons.removeAll()
            buttons.append(element)
        }
    }
    
    private func createPositionButtons() {
        for numeral in KeyBoardSymbol.allCases {
            let numeralButton = createButton(type: numeral)
            createStackViewNumber(element: numeralButton)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.translatesAutoresizingMaskIntoConstraints = false
        createPositionButtons()
        setViewHierarhies()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setViewHierarhies() {
        self.addSubview(mainStackView)
        containerStackView.addArrangedSubview(zeroStackView)
        containerStackView.addArrangedSubview(lastStackView)
        mainStackView.addArrangedSubview(containerStackView)
        zeroStackView.addArrangedSubview(zeroButton)
        lastStackView.addArrangedSubview(decimalSeparatorButton)
        lastStackView.addArrangedSubview(sumButton)
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            mainStackView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            mainStackView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
            mainStackView.topAnchor.constraint(equalTo: self.topAnchor),
            mainStackView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            zeroButton.widthAnchor.constraint(equalTo: mainStackView.widthAnchor, multiplier: 0.45)
        ])
    }
    
    @objc func buttonAction(sender: KeyBoardButton) {

        delegate?.onAction(type: sender.typeButton)
    }
}

