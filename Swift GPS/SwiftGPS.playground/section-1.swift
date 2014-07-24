// Playground - noun: a place where people can play

import UIKit
import CoreLocation
import MapKit

let EarthRadiusL = 6378.137
let EarthRadiusS = 6356.755
let PI = 3.141592653589793
let YardPerMeter = 1.093613298

extension Double {
    init(_ s: String) {
        let numberString = s as NSString
        self = numberString.doubleValue
    }
}

class Point: NSObject, MKAnnotation {
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
    
    class func arrayWithStringArray(coords: Array<String>) -> Array<Point> {
        var coordArray = Array<Point>()
        for s in coords {
            coordArray.append(self(string:s))
        }
        return coordArray
    }
    
    func toCGPoint() -> CGPoint {
        return CGPointMake(CGFloat(self.x), CGFloat(self.y))
    }
}

let ps = Point.arrayWithStringArray(["30.1, 120.0", "31.1, 120.0"])
let p = Point()

extension UIDevice {
    func deviceMajorVersion() -> Int! {
        return self.systemVersion.componentsSeparatedByString(".")[0].toInt()
    }
}

println("Version: \(UIDevice.currentDevice().deviceMajorVersion())")


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

(DeviceGeometry.mapCenterX, DeviceGeometry.mapCenterY)

// Returns distance in meters.
func getDistanceFromPoints(p1: Point, p2: Point) -> Double {
    func degreeToRadians(d: Double) -> Double {
        return (d * PI / 180.0)
    }
    var radius = EarthRadiusS + (EarthRadiusL - EarthRadiusS) * ((p1.x + p2.x)/180.0)
    let p1x = degreeToRadians(p1.x)
    let p2x = degreeToRadians(p2.x)
    let deltaX = p1x - p2x;
    let deltaY = degreeToRadians(p1.y) - degreeToRadians(p2.y);
    var s = 2 * asin(sqrt(pow(sin(deltaX / 2.0), 2.0) + cos(p1x) * cos(p2x) * pow(sin(deltaY / 2.0), 2.0)));
    s = (s * radius * 10000.0 + 0.5) / 10.0
    
    return s
}

getDistanceFromPoints(Point(string: "31.0, 120.0"), Point(string: "30.0, 120.0"))


