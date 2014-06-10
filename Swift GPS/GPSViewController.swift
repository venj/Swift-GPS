//
//  GPSViewController.swift
//  Swift GPS
//
//  Created by Venj Chu on 14/6/6.
//  Copyright (c) 2014年 Venj Chu. All rights reserved.
//

import UIKit
import CoreLocation

let kLatestTimeStamp = "LatestTimeStampKey"

class GPSViewController: UIViewController, CLLocationManagerDelegate, UIAlertViewDelegate {
    
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
    var recording = false
    var fm: NSFileManager!
    var fh: NSFileHandle!
    var path: NSString!

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
        
        title = NSLocalizedString("GPS", comment: "GPS");
        showOnMapButton.setTitle(NSLocalizedString("Map", comment: "Map"), forState:.Normal)
        theNewButton.setTitle(NSLocalizedString("New", comment: "New"), forState:.Normal)
        startButton.setTitle(NSLocalizedString("Start", comment: "Start"), forState:.Normal)
        latitudeTitleLabel.text = NSLocalizedString("Latitude", comment: "Latitude");
        longitudeTitleLabel.text = NSLocalizedString("Longitude", comment: "Longitude");
        altitudeTitleLabel.text = NSLocalizedString("Altitude", comment: "Altitude");
        hAccuracyTitleLabel.text = NSLocalizedString("H-Accu", comment: "H-Accu");
        vAccuracyTitleLabel.text = NSLocalizedString("V-Accu", comment: "V-Accu");
        timeTitleLabel.text = NSLocalizedString("Timestamp", comment: "Timestamp");
        speedTitleLabel.text = NSLocalizedString("Speed", comment: "Speed");
        dataBarButton.title = NSLocalizedString("Data", comment: "Data");
        
        manager = CLLocationManager()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.distanceFilter = kCLDistanceFilterNone
        manager.startUpdatingLocation()
        
        let defaults = NSUserDefaults.standardUserDefaults()
        let latestFileName : AnyObject! = defaults.objectForKey("LatestTimeStamp")
        var fileName = ""
        
        if let f = latestFileName as? String {
            fileName = f
        }
        else {
            fileName = "Default.txt"
        }
        
        path = NSHomeDirectory().stringByAppendingPathComponent("Documents").stringByAppendingPathComponent(fileName)
        fm = NSFileManager.defaultManager()
        if !fm.fileExistsAtPath(path) {
            fm.createFileAtPath(path, contents:nil, attributes:[:])
        }
        recording = false;
        containingView.contentSize = view.frame.size
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillDisappear(animated:Bool) {
        writeCoordsCacheToFile()
    }

    // #pragma mark - Navigation
    // TODO: Finish this segue
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
    
    @IBAction func startRecord(sender:AnyObject!) {
        if recording {
            writeCoordsCacheToFile();
            theNewButton.enabled = true
            recording = false
            startButton.setTitle(NSLocalizedString("Start", comment:"Start"), forState:.Normal)
        }
        else {
            theNewButton.enabled = false
            recording = true
            startButton.setTitle(NSLocalizedString("Pause", comment:"Pause"), forState:.Normal)
        }
    }
    
    func writeCoordsCacheToFile() {
        if coords.count == 0 {
            return
        }
        if !fm.fileExistsAtPath(path) {
            fm.createFileAtPath(path, contents:nil, attributes:[:])
        }
        fh = NSFileHandle(forWritingAtPath:path)
        fh.seekToEndOfFile()
        for str in coords {
            fh.writeData(str.dataUsingEncoding(NSUTF8StringEncoding))
        }
        fh.closeFile()
        coords = []
    }
    
    @IBAction func newFile(sender: AnyObject!) {
        let alert = UIAlertView()
        alert.title = NSLocalizedString("File name", comment: "File name")
        alert.message = NSLocalizedString("Please specify a filename for data file:", comment: "Please specify a filename for data file:")
        alert.delegate = self
        alert.addButtonWithTitle(NSLocalizedString("Cancel", comment: "Cancel"))
        alert.addButtonWithTitle(NSLocalizedString("OK", comment:"OK"))
        alert.alertViewStyle = .PlainTextInput;
        alert.show()
    }
    
    // UIAlertView Delegate
    func alertView(alertView: UIAlertView!, didDismissWithButtonIndex buttonIndex: Int) {
        if buttonIndex == 1 { // Index 1.
            var fileName: String
            let title = alertView.textFieldAtIndex(0).text
            if title != "" {
                fileName = "\(title).txt"
            }
            else {
                fileName = "Default.txt"
            }
            
            path = NSHomeDirectory().stringByAppendingPathComponent("Documents").stringByAppendingPathComponent(fileName)
            if fm.fileExistsAtPath(path) {
                let alert = UIAlertView()
                alert.title = NSLocalizedString("Error", comment: "Error")
                alert.message = NSLocalizedString("File already exists with the same name!", comment: "File already exists with the same name!")
                alert.addButtonWithTitle(NSLocalizedString("OK", comment:"OK"))
                alert.show()
            }
            else {
                writeCoordsCacheToFile()
                let defaults = NSUserDefaults.standardUserDefaults()
                defaults.setObject(fileName, forKey:kLatestTimeStamp)
                if !fm.fileExistsAtPath(path) {
                    fm.createFileAtPath(path, contents:nil, attributes:[:])
                }
                startRecord(nil)
            }
        }
        else { // Index 0.
            println("cancel here")
        }
    }
    
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: AnyObject[]!) {
        let newLocation = (locations as NSArray).lastObject as CLLocation
        latitudeLabel.text = NSString(format:"%.10f", newLocation.coordinate.latitude)
        longitudeLabel.text = NSString(format:"%.10f", newLocation.coordinate.longitude)
        altitudeLabel.text = NSString(format:"%.2f", newLocation.altitude)
        hAccuracyLabel.text = NSString(format:"%.2f", newLocation.horizontalAccuracy)
        vAccuracyLabel.text = NSString(format:"%.2f", newLocation.verticalAccuracy)
        let formatter = NSDateFormatter()
        formatter.timeStyle = .MediumStyle
        formatter.dateStyle = .ShortStyle
        let locale = NSLocale.systemLocale()
        formatter.locale = locale
        timeLabel.text = formatter.stringFromDate(newLocation.timestamp)
        speedLabel.text = NSString(format:"%.2f", newLocation.speed)
        currentLocation = newLocation
        
        if recording {
            coords.append(NSString(format:"%@,%@,%@,%@,%@,%.0f,%@\n", latitudeLabel.text, longitudeLabel.text, altitudeLabel.text, hAccuracyLabel.text, vAccuracyLabel.text, newLocation.timestamp.timeIntervalSince1970, speedLabel.text))
            
            if coords.count >= 10 {
                writeCoordsCacheToFile()
            }
        }
    }
}
