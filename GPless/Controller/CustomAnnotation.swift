//
//  CustomAnnotation.swift
//  GPless
//
//  Created by Khaled Bohout on 11/1/20.
//


import Foundation
// 1
import MapKit

// 2
class CustomAnnotation: NSObject, MKAnnotation
{
    // 3
    var coordinate: CLLocationCoordinate2D
    var title: String?
    
    // 4
    init(coor: CLLocationCoordinate2D)
    {
        coordinate = coor
    }
}
