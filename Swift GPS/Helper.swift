//
//  Helper.swift
//  Swift GPS
//
//  Created by Venj Chu on 14/6/6.
//  Copyright (c) 2014年 Venj Chu. All rights reserved.
//

import UIKit

let EarthRadiusL = 6378.137
let EarthRadiusS = 6356.755
let PI = 3.141592653589793
let YardPerMeter = 1.093613298

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

extension UIDevice {
    func deviceMajorVersion() -> Int! {
        return self.systemVersion.componentsSeparatedByString(".")[0].toInt()
    }
}

func UserDocumentPath() -> String {
    return NSHomeDirectory().stringByAppendingPathComponent("Documents")
}
