//
//  PointsResponse.swift
//  GPless
//
//  Created by Khaled Bohout on 12/17/20.
//

import Foundation

struct PointsResponse: Codable {
    var noOfPages: Int?
    var offers: [PointsResponseOffer]?
    var count: Int?

    enum CodingKeys: String, CodingKey {
        case noOfPages = "no_of_pages"
        case offers, count
    }
}

// MARK: - PointsResponseOffer
struct PointsResponseOffer: Codable {
    var number: Int?
    var date: String?
    var offers: [OfferModel]?
}
