//
//  SearchResult.swift
//  GPless
//
//  Created by Khaled Bohout on 11/24/20.
//

import Foundation

// MARK: - SearchResult
struct SearchResult: Codable {
    var offers: [OfferModel]?
    var noOfPages: Int?
    var count: Int?

    enum CodingKeys: String, CodingKey {
        case offers
        case noOfPages = "no_of_pages"
        case count
    }
}
