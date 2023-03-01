//
//  СalculatorWork.swift
//  Calculate
//
//  Created by APPLE on 24.02.2023.
//

import Foundation

protocol CalculatorWork {

    func computeFinalValue() -> String
    
    func choseOperator(type: KeyBoardSymbol)
    
    func calculatePercent(value: String) -> String
    
    func setPercent()
    
    func changeValue(value: String) -> String
    
    func setChangeValue()
    
    func createSum()
    
    func clearAll()
    
    func decimal()
    
    func reset()
}
