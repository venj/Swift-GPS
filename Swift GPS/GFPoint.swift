//
//  GFPoint.swift
//  Swift GPS
//
//  Created by Venj Chu on 14/6/6.
//  Copyright (c) 2014年 Venj Chu. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class GFPoint: NSObject, MKAnnotation {
    var x: Double = 0.0
    var y: Double = 0.0
    var title: String!
    var subtitle: String!
    var coordinate: CLLocationCoordinate2D {
        return CLLocationCoordinate2DMake(self.x, self.y)
    }
    
    init(x:Double = 0.0, y:Double = 0.0) {
        self.x = x
        self.y = y
    }
    
    convenience init(coordinateString:String) {
        let comps = coordinateString.componentsSeparatedByString(",")
        if comps.count != 2 {
            self.init()
        }
        else {
            let latString = comps[0] as String
            //let lat = latString.doubleValue
            self.init()
        }
    }
    
}
