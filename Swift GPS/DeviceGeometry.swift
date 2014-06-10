//
//  DeviceGeometry.swift
//  Swift GPS
//
//  Created by Venj Chu on 14/6/10.
//  Copyright (c) 2014年 Venj Chu. All rights reserved.
//

// Maybe not used

import UIKit

struct DeviceGeometry {
    static var mapAreaWidth: Double {
        return Double(UIScreen.mainScreen().bounds.size.width);
    }
    
    static var mapAreaHeight: Double {
        return Double(UIScreen.mainScreen().bounds.size.height)
    }
    
    static var mapCenterX: Double {
        return mapAreaWidth / 2.0
    }
    
    static var mapCenterY: Double {
        return mapAreaHeight / 2.0
    }
}
