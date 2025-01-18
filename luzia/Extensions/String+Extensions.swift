//
//  StringExtensions.swift
//  luzia
//
//  Created by Inigo Mato on 18/01/2025.
//

import Foundation

extension String {
    func prettyPrinted() -> String {
        Int(self)?.prettyPrinted() ?? self
    }
}
