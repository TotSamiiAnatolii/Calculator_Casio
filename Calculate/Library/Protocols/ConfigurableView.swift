//
//  ConfigurableView.swift
//  Calculate
//
//  Created by APPLE on 08.01.2023.
//

import Foundation

protocol ConfigurableView {
    associatedtype Model
    
    func configure(with model: Model)
}
