//
//  Offer.swift
//  GPless
//
//  Created by Khaled Bohout on 11/2/20.
//


import Foundation

// MARK: - Offer
struct NearestOffer: Codable {
    
    var vendor: Vendor?
    var location: Location?
    var offers: [String]?
}

// MARK: - Location
struct Location: Codable {
    var longitude, latitude: String?
}

// MARK: - Vendor
struct Vendor: Codable {
    var fullName: String?

    enum CodingKeys: String, CodingKey {
        case fullName = "full_name"
    }
}
