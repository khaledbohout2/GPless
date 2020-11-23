//
//  OfferBranchesResponse.swift
//  GPless
//
//  Created by Khaled Bohout on 11/22/20.
//

import Foundation

// MARK: - OfferBranchesResponse
struct OfferBranchesResponse: Codable {
    var offer: [OfferModel]?
    var branches: [BranchModel]?

    enum CodingKeys: String, CodingKey {
        case offer = "“offer”"
        case branches = "“branches”"
    }
}
