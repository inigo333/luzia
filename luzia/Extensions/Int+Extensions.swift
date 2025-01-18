//
//  IntExtensions.swift
//  luzia
//
//  Created by Inigo Mato on 18/01/2025.
//

import Foundation

extension Int {
    func prettyPrinted() -> String? {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = "."
        formatter.groupingSize = 3
        
        return formatter.string(from: NSNumber(value: self))
    }
}
