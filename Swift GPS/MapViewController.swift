//
//  MapViewController.swift
//  Swift GPS
//
//  Created by Venj Chu on 14/6/6.
//  Copyright (c) 2014年 Venj Chu. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate {
    
    var currentPoint: GFPoint!
    @IBOutlet var mapView: MKMapView
    @IBOutlet var mapTypeSegmentControl: UISegmentedControl

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
        mapTypeSegmentControl.setTitle(NSLocalizedString("Map", comment: "Map"), forSegmentAtIndex: 0);
        mapTypeSegmentControl.setTitle(NSLocalizedString("Satellite", comment: "Satellite"), forSegmentAtIndex: 1);
        mapTypeSegmentControl.setTitle(NSLocalizedString("Hybrid", comment: "Hybrid"), forSegmentAtIndex: 2);
        
        if self.mapView.annotations.count <= 1 {
            NSTimer.scheduledTimerWithTimeInterval(1, target:self, selector:"timerAction:", userInfo: nil, repeats: false)
            let height = 0.01
            let span = MKCoordinateSpanMake(0.75 * height, height);
            let centerCoord = currentPoint!.coordinate;
            let visibleRegion = MKCoordinateRegionMake(centerCoord, span);
            mapView.setRegion(visibleRegion, animated:true)
        }
        
        self.mapTypeSegmentControl.selectedSegmentIndex = 0;
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // #pragma mark - NSTimer Delegate
    func timerAction(timer: NSTimer) {
        mapView.addAnnotation(currentPoint)
    }
    
    func mapView(mapView: MKMapView!, viewForAnnotation annotation: MKAnnotation!) -> MKAnnotationView! {
        if let anno = annotation as? MKUserLocation {
            return mapView.viewForAnnotation(mapView.userLocation)
        }
        
        let AnnotationIdentifier = "StationPin";
        if let pinView = mapView.dequeueReusableAnnotationViewWithIdentifier(AnnotationIdentifier) {
            return pinView;
        }
        else {
            let pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: AnnotationIdentifier)
            pinView.animatesDrop = true
            pinView.canShowCallout = true
            if let anno = annotation as? GFPoint {
                anno.title = NSString(format:"%8f,%8f", anno.coordinate.latitude, anno.coordinate.longitude)
            }
            return pinView
        }
    }
    
    @IBAction func mapTypeChanged(sender: UISegmentedControl!) {
        let index = sender.selectedSegmentIndex
        switch index {
        case 2:
            mapView.mapType = .Hybrid
        case 1:
            mapView.mapType = .Satellite
        case 0:
            fallthrough
        default:
            mapView.mapType = .Standard
        }
    }
}
