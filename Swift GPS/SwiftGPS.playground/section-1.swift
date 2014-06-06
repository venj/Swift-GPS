// Playground - noun: a place where people can play

import UIKit
import CoreLocation
import MapKit

class GFPoint: NSObject, MKAnnotation {
    var x: Double = 0.0
    var y: Double = 0.0
    var title: String!
    var subtitle: String!
    var coordinate: CLLocationCoordinate2D {
    return CLLocationCoordinate2DMake(self.x, self.y)
    }
    
}
