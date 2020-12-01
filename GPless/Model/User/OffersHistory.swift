//
//  OffersHistory.swift
//  GPless
//
//  Created by Khaled Bohout on 12/1/20.
//

import Foundation

// MARK: - OffersHistory
struct OffersHistory: Codable {
    var noOfPages: Int?
    var offers: [OffersHistoryOffer]?
    var count: Int?

    enum CodingKeys: String, CodingKey {
        case noOfPages = "no_of_pages"
        case offers, count
    }
}

// MARK: - OffersHistoryOffer
struct OffersHistoryOffer: Codable {
    var date: String?
    var offers: [OfferModel]?
}
