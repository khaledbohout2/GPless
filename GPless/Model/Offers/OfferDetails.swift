//
//  OfferDetails.swift
//  GPless
//
//  Created by Khaled Bohout on 12/2/20.
//

import Foundation

// MARK: - OfferDetails
struct OfferDetails: Codable {
    var offer: OfferModel?
    var branches: [Branch]?
}

// MARK: - Branch
struct Branch: Codable {
    var id: Int?
    var name, longitude, latitude, city: String?
    var address, phone, startTime, endTime: String?
    var vendorID, userID: Int?
    var createdAt, updatedAt: String?

    enum CodingKeys: String, CodingKey {
        case id, name, longitude, latitude, city, address, phone
        case startTime = "start_time"
        case endTime = "end_time"
        case vendorID = "vendor_id"
        case userID = "user_id"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}
