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
