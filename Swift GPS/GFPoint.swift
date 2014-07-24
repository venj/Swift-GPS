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
    var x: Double
    var y: Double
    var title: String!
    var subtitle: String!
    var coordinate: CLLocationCoordinate2D {
    return CLLocationCoordinate2DMake(self.x, self.y)
    }
    
    init(x:Double = 0.0, y:Double = 0.0) {
        self.x = x
        self.y = y
    }
    
    required convenience init(string:String) {
        let comps = string.componentsSeparatedByString(",")
        if comps.count != 2 {
            self.init()
        }
        else {
            self.init(x: Double(comps[0]), y: Double(comps[1]))
        }
    }
    
    convenience init(coord: Array<Double>) {
        if coord.count == 2 {
            self.init(x:coord[0], y:coord[1])
        }
        else {
            self.init()
        }
    }
    
    convenience init(p: CGPoint) {
        let lat = Double(p.x)
        let lng = Double(p.y)
        self.init(x: lat, y: lng)
    }
    
    class func arrayWithStringArray(coords: Array<String>) -> Array<GFPoint> {
        var coordArray = Array<GFPoint>()
        for s in coords {
            coordArray.append(self(string:s))
        }
        return coordArray
    }
    
    func toCGPoint() -> CGPoint {
        return CGPointMake(CGFloat(self.x), CGFloat(self.y))
    }
}

