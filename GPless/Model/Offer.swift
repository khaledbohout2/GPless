//
//  Offer.swift
//  GPless
//
//  Created by Khaled Bohout on 11/1/20.
//

import Foundation

struct Offer {
    
    var lat: Double!
    var long: Double!
    var title: String!
    
    init(lat: Double, long: Double, title: String) {
        self.lat = lat
        self.long = long
        self.title = title
    }
}
