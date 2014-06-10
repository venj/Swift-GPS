//
//  GFMapRect.swift
//  Swift GPS
//
//  Created by Venj Chu on 14/6/10.
//  Copyright (c) 2014年 Venj Chu. All rights reserved.
//

// Maybe not used

import UIKit

class GFMapRect: NSObject {
    var p0: GFPoint
    var p1: GFPoint
    var p2: GFPoint
    var p3: GFPoint
    
    init(array: Array<String>, separator: String)  {
        self.p0 = GFPoint(string: array[0])
        self.p1 = GFPoint(string: array[1])
        self.p2 = GFPoint(string: array[2])
        self.p3 = GFPoint(string: array[3])
    }
    
    convenience init(array: Array<String>) {
        self.init(array:array, separator:" ")
    }
}
