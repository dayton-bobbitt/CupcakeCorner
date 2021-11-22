//
//  NumberFormatter+formatCurrency.swift
//  CupcakeCorner
//
//  Created by Dayton Bobbitt on 11/21/21.
//

import Foundation

extension NumberFormatter {
    private static let currencyFormatter: NumberFormatter = {
        var formatter = NumberFormatter()
        
        formatter.numberStyle = .currency
        
        return formatter
    }()
    
    static func formatCurrency(_ value: Double) -> String {
        guard let currency = currencyFormatter.string(from: NSNumber(value: value)) else {
            fatalError("Failed to format \(value) as currency")
        }
        
        return currency
    }
}
