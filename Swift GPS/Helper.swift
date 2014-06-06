//
//  Helper.swift
//  Swift GPS
//
//  Created by Venj Chu on 14/6/6.
//  Copyright (c) 2014年 Venj Chu. All rights reserved.
//

import Foundation

extension String {
    func doubleValue() -> Double {
        let numberString = self as NSString
        let number: Double = numberString.doubleValue
        return number
    }
}

extension Double {
    init(_ s: String) {
        let numberString = s as NSString
        self = numberString.doubleValue
    }
}
