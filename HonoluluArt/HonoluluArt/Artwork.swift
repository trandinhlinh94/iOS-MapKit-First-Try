//
//  Artwork.swift
//  HonoluluArt
//
//  Created by Linh Tran on 31/05/16.
//  Copyright © 2016 Linh Tran. All rights reserved.
//

import Foundation
import MapKit
import Contacts

class Artwork: NSObject, MKAnnotation {
    
    let title: String?
    let locationName: String
    let discipline: String
    let coordinate: CLLocationCoordinate2D
    
    // initialier
    init(title: String, locationName: String, discipline: String, coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.locationName = locationName
        self.discipline = discipline
        self.coordinate = coordinate
        
        super.init()
    }
    
    
    class func fromJSON(json: [JSONValue]) -> Artwork {
        // 1 
        var title: String
        if let titleOrNil = json[16].string {
            title = titleOrNil
        } else {
            title = ""
        }
        let locationName = json[12].string
        let discipline = json[15].string
        
        // 2 
        let latitude = (json[18].string! as NSString).doubleValue
        let longitude = ( json[19].string! as NSString).doubleValue
        let coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        
        // 3 
        return Artwork(title: title, locationName: locationName!, discipline: discipline!, coordinate: coordinate)
        
        /* NOTES
        1 fromJSON‘s json argument will be one of the arrays that represent an artwork – an array of JSONValue objects. If we count through an array’s elements, we'll see that the title, locationName etc. are at the indexes specified in this method. The title for some of the artworks is null so we test for this when setting the title value.
         
        2 This converts the string latitude and longitudes to NSString objects so we can then use the handy doubleValue to convert them to doubles.
         
        3 The computed string property from JSON.swift returns an optional string for locationName and discipline, which must be implicitly unwrapped when passing them to the Artwork initializer
        */
        
    }
    
    
    var subtitle: String? {
        return locationName
    }
    
    // annotation callout info button open this mapItem in Maps app
    func mapItem() -> MKMapItem {
        let addressDictionary = [CNPostalAddressStreetKey: subtitle!]
        let placemark = MKPlacemark(coordinate: coordinate, addressDictionary: addressDictionary)
        
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = title
        
        return mapItem
    }
    
    // pinColor for discipline: Scrulpture, Plague, Mural, Monument and others
    func pinTintColor() -> UIColor {
        switch discipline {
        case "Scrulpture", "Plague":
            return MKPinAnnotationView.redPinColor()
        case "Mural", "Monument":
            return MKPinAnnotationView.purplePinColor()
        default:
            return MKPinAnnotationView.greenPinColor()
        }
    }
    
    

}