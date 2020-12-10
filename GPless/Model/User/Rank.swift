//
//  Rank.swift
//  GPless
//
//  Created by Khaled Bohout on 12/1/20.
//

import Foundation

// MARK: - Rank
struct Rank: Codable {
    
    var users: [UserRank]?
    var authUser: UserRank?

    enum CodingKeys: String, CodingKey {
        case users
        case authUser = "auth_user"
    }
}

// MARK: - User
struct UserRank: Codable {
    
    var accountName: String?
    var rank, value: Int?
    var photoLink: String?

    enum CodingKeys: String, CodingKey {
        case accountName = "account_name"
        case rank, value
        case photoLink = "photo_link"
    }
}
