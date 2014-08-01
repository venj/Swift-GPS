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
    return p1.location.distanceFromLocation(p2.location)
}
