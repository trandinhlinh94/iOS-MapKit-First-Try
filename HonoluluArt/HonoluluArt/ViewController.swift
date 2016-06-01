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
    
    
    // PARSING JSON FILE
    // create an array to hold Artwork objects extracting from JSON file
    var artworks = [Artwork]()
    
    func loadInitialData() {
        // 1 
        let fileName = NSBundle.mainBundle().pathForResource("PublicArt", ofType: "json")
        var data: NSData?
        do {
            data = try NSData(contentsOfFile: fileName!, options: NSDataReadingOptions(rawValue: 0))
        } catch _ {
            data = nil
        }
        
        // 2
        var jsonObject: AnyObject? = nil
        if let data = data {
            do {
                jsonObject = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions(rawValue: 0))
            } catch _ {
                jsonObject = nil
            }
        }
        
        // 3 
        if let jsonObject = jsonObject as? [String: AnyObject] {
        
        // 4 
            if let jsonData = JSONValue.fromObject(jsonObject)?["data"]?.array {
                for artworkJSON in jsonData {
                    if let artworkJSON = artworkJSON.array {
        // 5
                        let artwork  = Artwork.fromJSON(artworkJSON)
                        artworks.append(artwork)
                    }
                }
            }
        }
        
        /*
         
        1 Read the PublicArt.json file into an NSData object
         
        2 Use NSJSONSerialization to obtain a JSON object
         
        3 Check that the JSON object is a dictionary where the keys are Strings and the values can be AnyObject
         
        4 We’re only interested in the JSON object whose key is "data" and we loop through that array of arrays, checking that each element is an array
         
        5 Pass each artwork’s array to the fromJSON method that you just added to the Artwork class. If it returns a valid Artwork object, we append it to the artworks array.
 
        */
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        centerMapOnLocation(initialLocation)
        
        //show artworks on map
        loadInitialData()
        mapView.addAnnotations(artworks)
        
        mapView.delegate = self
        
    }
    
    /*
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    */
    
    


}

