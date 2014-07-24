//
//  DistanceCalculateViewController.swift
//  Swift GPS
//
//  Created by Venj Chu on 14/6/13.
//  Copyright (c) 2014年 Venj Chu. All rights reserved.
//

import UIKit
import CoreLocation

class DistanceCalculateViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet var fromLatField: UITextField!
    @IBOutlet var fromLngField: UITextField!
    @IBOutlet var toLatField: UITextField!
    @IBOutlet var toLngField: UITextField!
    @IBOutlet var distanceLabel: UILabel!
    @IBOutlet var infoLabel: UILabel!
    
    var currentLocation: CLLocation!
    var manager: CLLocationManager!
    
    init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        // Custom initialization
    }
    
    init(coder aDecoder: NSCoder!)  {
        super.init(coder:aDecoder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        manager = CLLocationManager()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.distanceFilter = kCLDistanceFilterNone
        manager.startUpdatingLocation()
    }
    
    override func viewWillDisappear(animated: Bool) {
        manager.stopUpdatingLocation()
    }
    
    override func viewWillAppear(animated: Bool) {
        manager.startUpdatingLocation()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func getCurrentLocation(sender: AnyObject!) {
        //Fixme: Failed with capture list. Fall back to traditional resolution.
        dispatch_async(dispatch_get_main_queue()) { [weak self] in
            self!.toLatField.text = NSString(format:"%.8f", self!.currentLocation.coordinate.latitude)
            self!.toLngField.text = NSString(format:"%.8f", self!.currentLocation.coordinate.longitude)
        }
    }
    
    @IBAction func calculateDistance(sender: AnyObject!) {
        let fromLat = Double(fromLatField.text)
        let fromLng = Double(fromLngField.text)
        let toLat = Double(toLatField.text)
        let toLng = Double(toLngField.text)
        
        fromLatField.resignFirstResponder()
        fromLngField.resignFirstResponder()
        toLatField.resignFirstResponder()
        toLngField.resignFirstResponder()
        
        // Potential bug for UK Guys. ;)
        if fromLng == 0.0 || fromLng == 0.0 || toLat == 0.0 || toLng == 0.0 {
            return;
        }
        
        let from = Point(coord:[fromLat, fromLng])
        let to = Point(coord:[toLat, toLng])
        let distance = getDistanceFromPoints(from, to)
        distanceLabel.text = NSString.localizedStringWithFormat(NSLocalizedString("%.2f yd / %.2f m", comment: "%.2f yd / %.2f m"), fabs(distance), fabs(distance) / YardPerMeter)
    }
    
    // #pragma mark - Navigation
    override func prepareForSegue(segue: UIStoryboardSegue?, sender: AnyObject?) {
        if let s = segue {
            if (s.identifier == "FromToMap") {
                let p = Point(coord:[Double(fromLatField.text), Double(fromLngField.text)]);
                (s.destinationViewController as MapViewController).currentPoint = p
            }
            if (s.identifier == "ToToMap") {
                let p = Point(coord:[Double(toLatField.text), Double(toLngField.text)]);
                (s.destinationViewController as MapViewController).currentPoint = p
            }
        }
    }
    
    // #pragma mark - CLLocation Manager Delegate
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        if let locationArray = locations as? [CLLocation] {
            let newLocation = locationArray[locationArray.count - 1]
            infoLabel.text = NSString.localizedStringWithFormat(NSLocalizedString("Alt: %.2f H-Acc: %.2f V-Acc: %.2f", comment:"Alt: %.2f H-Acc: %.2f V-Acc: %.2f"), newLocation.altitude, newLocation.horizontalAccuracy, newLocation.verticalAccuracy)
            currentLocation = newLocation;
        }
    }

}
