//
//  Favourite.swift
//  GPless
//
//  Created by Khaled Bohout on 11/22/20.
//

// MARK: - Favourite
struct Favourite: Codable {
    var id: Int?
    var offerID, userID, createdAt, updatedAt: String?

    enum CodingKeys: String, CodingKey {
        case id
        case offerID = "offer_id"
        case userID = "user_id"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}
