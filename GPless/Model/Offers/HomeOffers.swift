//
//  HomeOffers.swift
//  GPless
//
//  Created by Khaled Bohout on 11/23/20.
//

import Foundation

// MARK: - HomeOffers
struct HomeOffers: Codable {
    var freeOffers: [OfferModel]?
    var paidOffers: [OfferModel]?
    var featured: [Brand]?

    enum CodingKeys: String, CodingKey {
        case freeOffers = "free_offers"
        case paidOffers = "paid_offers"
        case featured
    }
}
