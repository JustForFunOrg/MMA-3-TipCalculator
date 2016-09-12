//
//  DoubleExtension.swift
//  TipCalculator
//
//  Created by Michail on 9/12/16.
//  Copyright © 2016 mishaparadising. All rights reserved.
//

import Foundation

extension Double {
    func formatWithDefaultValue() -> String {
        let defaultFormatForDouble = ".2"
        return format(defaultFormatForDouble)
    }
    
    func format(f: String) -> String {
        return NSString(format: "%\(f)f", self) as String
    }
}