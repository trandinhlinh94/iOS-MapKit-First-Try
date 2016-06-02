//
//  VCMapView.swift
//  HonoluluArt
//
//  Created by Linh Tran on 31/05/16.
//  Copyright © 2016 Linh Tran. All rights reserved.
//

import Foundation
import MapKit

extension ViewController: MKMapViewDelegate {
    // 1 
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation)-> MKAnnotationView? {
        if let annotation = annotation as? Artwork {
            let identifier = "pin"
            var view = MKPinAnnotationView()
            if let dequeuedView = mapView.dequeueReusableAnnotationViewWithIdentifier(identifier) as? MKPinAnnotationView {
    // 2
                    dequeuedView.annotation = annotation
                    view = dequeuedView
            } else {
    // 3                    
                view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                view.canShowCallout = true
                view.calloutOffset = CGPoint(x: -5, y: 5)
                view.rightCalloutAccessoryView = UIButton(type: UIButtonType.DetailDisclosure) as UIView
            }
            return view
        }
        return nil
        
        
    /*
    
    1  mapView(_:viewForAnnotation:) is the method that gets called for every annotation you add to the map (kind of like tableView(_:cellForRowAtIndexPath:) when working with table views), to return the view for each annotation.
    
    2  Also similarly to tableView(_:cellForRowAtIndexPath:), map views are set up to reuse annotation views when some are no longer visible. So the code first checks to see if a reusable annotation view is available before creating a new one.
       
    3  Here we use the plain vanilla MKAnnotationView class if an annotation view could not be dequeued. It uses the title and subtitle properties of Artwork class to determine what to show in the callout – the little bubble that pops up when the user taps on the pin.

         
    */
    }
    
    
    /*
    When the user taps a map annotation pin, the callout shows an info button. If the user taps this info button, the mapView(_:annotationView:calloutAccessoryControlTapped:) method is called.
    In this method, you grab the Artwork object that this tap refers to and then launch the Maps app by creating an associated MKMapItem and calling openInMapsWithLaunchOptions on the map item.
    */
    func mapView(mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        let location = view.annotation as! Artwork
        let launchOptions = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving]
        location.mapItem().openInMapsWithLaunchOptions(launchOptions)
    }
    
}
