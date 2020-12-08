//
//  ConfirmOfferResponse.swift
//  GPless
//
//  Created by Khaled Bohout on 11/22/20.
//

import Foundation

// MARK: - ConfirmOfferResponse
struct ConfirmOfferResponse: Codable {
    var id: Int?
    var state: String?
    var error: String?
}

enum CodingKeys: String, CodingKey {
    case id, state
    case error = "Error"
}
