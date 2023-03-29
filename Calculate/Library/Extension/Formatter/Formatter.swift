//
//  Formatter.swift
//  Calculate
//
//  Created by APPLE on 12.01.2023.
//

import Foundation

extension Formatter {
    
    static let formatter = NumberFormatter()

    static let formatterFromDouble: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.roundingMode = .up
        formatter.locale = Locale.current
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = " "
        formatter.maximumIntegerDigits = 9
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 10
        return formatter
    }()
    
    static func formatToValue() -> NumberFormatter {
        formatter.roundingMode = .up
        formatter.locale = Locale.current
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 7
        formatter.groupingSeparator = " "
        return formatter
    }
}

extension Numeric {
    
    var formatterFrom: String { Formatter.formatterFromDouble.string(for: self) ?? "" }
}
