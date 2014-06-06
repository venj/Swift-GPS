//
//  GPSViewController.swift
//  Swift GPS
//
//  Created by Venj Chu on 14/6/6.
//  Copyright (c) 2014年 Venj Chu. All rights reserved.
//

import UIKit
import CoreLocation

class GPSViewController: UIViewController, CLLocationManagerDelegate {
    
    // #pragma mark - Properties
    @IBOutlet var latitudeTitleLabel: UILabel
    @IBOutlet var latitudeLabel: UILabel
    @IBOutlet var longitudeTitleLabel: UILabel
    @IBOutlet var longitudeLabel: UILabel
    @IBOutlet var altitudeTitleLabel: UILabel
    @IBOutlet var altitudeLabel: UILabel
    @IBOutlet var hAccuracyTitleLabel: UILabel
    @IBOutlet var hAccuracyLabel: UILabel
    @IBOutlet var vAccuracyTitleLabel: UILabel
    @IBOutlet var vAccuracyLabel: UILabel
    @IBOutlet var timeTitleLabel: UILabel
    @IBOutlet var timeLabel: UILabel
    @IBOutlet var speedTitleLabel: UILabel
    @IBOutlet var speedLabel: UILabel
    @IBOutlet var showOnMapButton: UIButton
    @IBOutlet var startButton: UIButton
    @IBOutlet var theNewButton: UIButton
    @IBOutlet var containingView: UIScrollView
    @IBOutlet var dataBarButton: UIBarButtonItem
    
    var currentLocation: CLLocation?
    var manager: CLLocationManager!
    var coords: Array<String> = []
    var isRecording = false
    var fm: NSFileManager!
    var fh: NSFileHandle!
    var path: NSString!

    init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        // Custom initialization
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.title = NSLocalizedString("GPS", comment: "GPS");
        self.showOnMapButton.setTitle(NSLocalizedString("Map", comment: "Map"), forState:.Normal)
        self.theNewButton.setTitle(NSLocalizedString("New", comment: "New"), forState:.Normal)
        self.startButton.setTitle(NSLocalizedString("Start", comment: "Start"), forState:.Normal)
        self.latitudeTitleLabel.text = NSLocalizedString("Latitude", comment: "Latitude");
        self.longitudeTitleLabel.text = NSLocalizedString("Longitude", comment: "Longitude");
        self.altitudeTitleLabel.text = NSLocalizedString("Altitude", comment: "Altitude");
        self.hAccuracyTitleLabel.text = NSLocalizedString("H-Accu", comment: "H-Accu");
        self.vAccuracyTitleLabel.text = NSLocalizedString("V-Accu", comment: "V-Accu");
        self.timeTitleLabel.text = NSLocalizedString("Timestamp", comment: "Timestamp");
        self.speedTitleLabel.text = NSLocalizedString("Speed", comment: "Speed");
        self.dataBarButton.title = NSLocalizedString("Data", comment: "Data");
        
        
        self.manager = CLLocationManager()
        self.manager.delegate = self
        self.manager.desiredAccuracy = kCLLocationAccuracyBest
        self.manager.startUpdatingLocation()
        let defaults = NSUserDefaults.standardUserDefaults()
        let latestFileName : AnyObject! = defaults.objectForKey("LatestTimeStamp")
        var fileName = ""
        
        if let f = latestFileName as? String {
            fileName = f
        }
        else {
            fileName = "Default.txt"
        }
        
        self.path = NSHomeDirectory().stringByAppendingPathComponent("Documents").stringByAppendingPathComponent(fileName)
        self.fm = NSFileManager.defaultManager()
        if !self.fm.fileExistsAtPath(self.path) {
            self.fm.createFileAtPath(self.path, contents:nil, attributes:[:])
        }
        self.isRecording = false;
        self.containingView.contentSize = CGSizeMake(320, 280)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillDisappear(animated:Bool) {
        //self.writeCoordsCacheToFile()
    }

    // #pragma mark - Navigation
    override func prepareForSegue(segue: UIStoryboardSegue?, sender: AnyObject?) {
        if segue!.identifier == "tomap" {
            let dest = segue!.destinationViewController as MapViewController
            
        }
        /*
        if ([[segue identifier] isEqualToString:@"tomap"]) {
            GFPoint *p = [[GFPoint alloc] initWithLatitude:self.currentLocation.coordinate.latitude longitude:self.currentLocation.coordinate.longitude];
            [(MapViewController *)segue.destinationViewController setCurrentPoint:p];
        } */
    }

    // #pragma mark - Helper Methods
    
}
