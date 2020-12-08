//
//  Profile.swift
//  GPless
//
//  Created by Khaled Bohout on 11/30/20.
//

import Foundation


// MARK: - Profile
struct Profile: Codable {
    var accountName: String?
    var rank: Int?
    var points: Int?

    enum CodingKeys: String, CodingKey {
        case accountName = "account_name"
        case points, rank
    }
}
