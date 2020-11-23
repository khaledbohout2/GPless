//
//  RateModel.swift
//  GPless
//
//  Created by Khaled Bohout on 11/22/20.
//

import Foundation

// MARK: - RateModel
struct RateModel: Codable {
    var userID, offerID, value: String?

    enum CodingKeys: String, CodingKey {
        case userID = "User_id"
        case offerID = "Offer_id"
        case value = "Value"
    }
}
