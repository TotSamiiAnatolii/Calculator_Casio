//
//  ViewController.swift
//  Calculate
//
//  Created by USER on 05.01.2023.
//

import UIKit

final class MainViewController: UIViewController {
    
    fileprivate var mainView: MainView {
        guard let view = self.view as? MainView else {return MainView()}
        return view
    }
    
    private var previousOperand: String = ""
    private var currentOperand: String = ""
    private var operationsTypes: Operator = .none
    private var sumState: equalsState = .notСounted
    private let empty: String = ""
    private let zero: String = KeyBoardSymbol.zero.rawValue
    private let decimalSeparator = Locale.current.decimalSeparator
    
    override func loadView() {
        super.loadView()
        self.view = MainView(frame: UIScreen.main.bounds)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainView.keyBoard.delegate = self
        configureView()
    }
    
    private func configureView() {
        mainView.configure(with: ModelMainView())
    }
    
    private let printScientificFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        let locale = Locale.current
        formatter.numberStyle = .scientific
        formatter.minimumFractionDigits = 3
        formatter.exponentSymbol = "e"
        return formatter
    }()
    
    private func setNumber(type: KeyBoardSymbol) {
        
        let number = type.rawValue
        
        switch sumState {
        case .counted:
            mainView.displayView.delete()
            previousOperand = empty
            previousOperand += number
            sumState = .countAgain
            
        case .notСounted:
            
            switch operationsTypes == .none {
            case true:
                previousOperand += number
                
            case false:
                if currentOperand == empty {
                    mainView.displayView.delete()
                }
                currentOperand += number
            }
        case .countAgain:
            previousOperand += number
        }
        mainView.displayView.setValue(value: number)
    }
}
extension MainViewController: CalculatorWork {
    
    func computeFinalValue() -> String {
        let previous = previousOperand.convertTextInDouble()
        let current = currentOperand.convertTextInDouble()
        var output: Double = 0.0
        
        switch operationsTypes {
        case .multiply:
            output = previous * current
        case .divide:
            output = previous / current
        case .plus:
            output = previous + current
        case .minus:
            output = previous - current
        default:
            break
        }
        previousOperand = NumberFormatter.formatToCurrency().string(from: output as NSNumber) ?? empty
        
        return previousOperand
    }
    
    func choseOperator(type: KeyBoardSymbol) {
        currentOperand = empty
        sumState = .notСounted
        
        switch type {
        case .divide:
            operationsTypes = .divide
        case .multiply:
            operationsTypes = .multiply
        case .minus:
            operationsTypes = .minus
        case .plus:
            operationsTypes = .plus
        default:
            break
        }
    }
    
    func calculatePercent(value: String) -> String {
        mainView.displayView.delete()
        guard let number = Decimal(string: value, locale: Locale.current) else { return zero }
        
        let result = number / 100
        
        guard let convertResult = NumberFormatter.formatToCurrency().string(from: result as NSNumber) else { return empty }
        mainView.displayView.setValue(value: convertResult)
        return convertResult
    }
    
    func setPercent() {
        switch sumState {
        case .counted:
            previousOperand = calculatePercent(value: previousOperand)
        case .notСounted:
            if operationsTypes == .none  {
                previousOperand = calculatePercent(value: previousOperand)
            }
            
            if operationsTypes != .none && currentOperand == empty {
                previousOperand = calculatePercent(value: previousOperand)
                return
            }
            
            if operationsTypes != .none  {
                currentOperand = calculatePercent(value: currentOperand)
            }
        case .countAgain:
            previousOperand = calculatePercent(value: previousOperand)
        }
    }
    
    func changeValue(value: String) -> String {
        mainView.displayView.delete()
        if value == zero || value == "-0" {
            let zero = value == zero ? "-0" : zero
            mainView.displayView.setValue(value: zero)
            return zero
        }
        let number = value.convertTextInDouble()
        let koef: Double = -1
        
        let rezult = number * koef
        guard let convertResult = NumberFormatter.formatToCurrency().string(from: rezult as NSNumber) else { return empty }
        mainView.displayView.setValue(value: convertResult)
        return convertResult
    }
    
    func setChangeValue() {
        switch sumState {
        case .counted:
            previousOperand = changeValue(value: previousOperand)
        case .notСounted:
            if operationsTypes == .none {
                previousOperand = changeValue(value: previousOperand)
            }
            
            if operationsTypes != .none && currentOperand == empty {
                previousOperand = changeValue(value: previousOperand)
                return
            }
            
            if operationsTypes != .none {
                currentOperand = changeValue(value: currentOperand)
            }
        case .countAgain:
            previousOperand = changeValue(value: previousOperand)
        }
    }
    
    func createSum() {
        let sum = computeFinalValue()
        mainView.displayView.delete()
        mainView.displayView.setValue(value: sum)
        sumState = .counted
    }
    
    func clearAll() {
        reset()
        mainView.displayView.clear()
        operationsTypes = .none
        sumState = .notСounted
    }
    
    func decimal() {
        guard let decimalSeparator = decimalSeparator else { return }
        
        switch sumState {
        case .counted:
            if previousOperand.range(of: decimalSeparator ) == nil {
                previousOperand += decimalSeparator
                mainView.displayView.setValue(value: decimalSeparator)
                sumState = .countAgain
            }
        case .notСounted:
            if operationsTypes == .none && (previousOperand.range(of: decimalSeparator) == nil)  {
                previousOperand += decimalSeparator
                mainView.displayView.setValue(value: decimalSeparator)
            }
            
            if operationsTypes != .none  {
                if currentOperand == empty {
                    mainView.displayView.delete()
                    currentOperand = zero
                    mainView.displayView.setValue(value: currentOperand)
                }
                currentOperand += decimalSeparator
                mainView.displayView.setValue(value: decimalSeparator)
                return
            }
        case .countAgain:
            if previousOperand.range(of: decimalSeparator ) == nil {
                previousOperand += decimalSeparator
                mainView.displayView.setValue(value: decimalSeparator)
            }
        }
    }
    
    func reset() {
        self.previousOperand = empty
        self.currentOperand = empty
    }
}

extension MainViewController: KeyBoardDelegate {
    
    func onAction(type: KeyBoardSymbol) {
        
        switch type {
        case .plus, .divide, .multiply, .minus:
            choseOperator(type: type)
            
        case .zero, .one, .two, .three, .four, .five, .six, .seven, .eight, .nine:
            setNumber(type: type)
            
        case .percent:
            setPercent()
            
        case .decimal:
            decimal()
            
        case .ac:
            clearAll()
            
        case .plusMinus:
            setChangeValue()
            
        case .sum:
            createSum()
        }
    }
}
