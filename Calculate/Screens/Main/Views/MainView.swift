//
//  MainView.swift
//  Calculate
//
//  Created by USER on 05.01.2023.
//

import UIKit

final class MainView: UIView {
    
    public let displayView = Display(frame: .zero)
    
    private let solorPanel = SolarPanel(frame: .zero)
    
    public let keyBoard = KeyBoard(frame: .zero)
    
    private let titleBrand: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Fonts.nameBrand
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = Colors.bodyColor
        serViewHierarhies()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - View hierarchy
    private func serViewHierarhies() {
        self.addSubview(displayView)
        self.addSubview(solorPanel)
        self.addSubview(titleBrand)
        self.addSubview(keyBoard)
    }
    
    
    //MARK: - Constraints
    private func setConstraints() {
        NSLayoutConstraint.activate([
            displayView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.9),
            displayView.heightAnchor.constraint(equalToConstant: 110),
            displayView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            displayView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 100)
        ])
        
        NSLayoutConstraint.activate([
            solorPanel.widthAnchor.constraint(equalTo: displayView.widthAnchor, multiplier: 0.3),
            solorPanel.heightAnchor.constraint(equalToConstant: 40),
            solorPanel.rightAnchor.constraint(equalTo: displayView.rightAnchor),
            solorPanel.topAnchor.constraint(equalTo: displayView.bottomAnchor, constant: 20)
        ])
        
        NSLayoutConstraint.activate([
            titleBrand.centerYAnchor.constraint(equalTo: solorPanel.centerYAnchor),
            titleBrand.leftAnchor.constraint(equalTo: displayView.leftAnchor, constant: 10)
        ])
        
        NSLayoutConstraint.activate([
            keyBoard.widthAnchor.constraint(equalTo: self.widthAnchor),
            keyBoard.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            keyBoard.topAnchor.constraint(equalTo: solorPanel.bottomAnchor, constant: 20),
            keyBoard.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}
extension MainView: ConfigurableView {
    typealias Model = ModelMainView
    
    func configure(with model: ModelMainView) {
        self.titleBrand.text = model.nameBrand
    }
}
