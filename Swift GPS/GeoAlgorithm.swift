//
//  GeoAlgorithm.swift
//  Swift GPS
//
//  Created by Venj Chu on 14/6/10.
//  Copyright (c) 2014年 Venj Chu. All rights reserved.
//

import Foundation

// Returns distance in meters.
func getDistanceFromPoints(p1: Point, p2: Point) -> Double {
    func degreeToRadians(d: Double) -> Double {
        return (d * PI / 180.0)
    }
    var radius = EarthRadiusS + (EarthRadiusL - EarthRadiusS) * ((p1.x + p2.x) / 180.0)
    let p1x = degreeToRadians(p1.x)
    let p2x = degreeToRadians(p2.x)
    let deltaX = p1x - p2x;
    let deltaY = degreeToRadians(p1.y) - degreeToRadians(p2.y);
    var s = 2 * asin(sqrt(pow(sin(deltaX / 2.0), 2.0) + cos(p1x) * cos(p2x) * pow(sin(deltaY / 2.0), 2.0)));
    s = (s * radius * 10000.0 + 0.5) / 10.0
    
    return s
}
