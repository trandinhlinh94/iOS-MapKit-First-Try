//
//  ViewController.swift
//  HonoluluArt
//
//  Created by Linh Tran on 31/05/16.
//  Copyright © 2016 Linh Tran. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController {
    
    // MARK PROPERTIES 
    
    @IBOutlet weak var mapView: MKMapView!
    
    
    //set initial location in Honolulu
    let initialLocation = CLLocation(latitude: 21.282778, longitude: -157.829444)
    
    // set central map region
    let regionRadius: CLLocationDistance = 1000
    
    func centerMapOnLocation (location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, regionRadius * 2.0, regionRadius * 2.0)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        centerMapOnLocation(initialLocation)
        
    }
    /*
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    */
    
    


}

