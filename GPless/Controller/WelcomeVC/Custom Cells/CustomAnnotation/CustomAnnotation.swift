//
//  CustomAnnotation.swift
//  GPless
//
//  Created by Khaled Bohout on 11/23/20.
//

import UIKit
import MapKit

class CustomAnnotation: NSObject, MKAnnotation {
    
    // This property must be key-value observable, which the `@objc dynamic` attributes provide.
    @objc dynamic var coordinate = CLLocationCoordinate2D(latitude: 30.025363799999997, longitude: 31.481323999999994)
    
    var offers: NearestOffer?
    var vendor: Vendor?
    
    init(coordinate: CLLocationCoordinate2D, offers: NearestOffer, vendor: Vendor) {
        
        self.coordinate = coordinate
        self.offers = offers
        self.vendor = vendor
    }
}
