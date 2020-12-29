//
//  Profile.swift
//  GPless
//
//  Created by Khaled Bohout on 11/30/20.
//

import Foundation


// MARK: - Profile
struct Profile: Codable {
    
    var accountName, premuimEnd, premuimType, photoLink, email: String?
    var fullName, gender: String
    var rank, permuim, points, id: Int?

    enum CodingKeys: String, CodingKey {
        
        case accountName = "account_name"
        case points, rank, permuim, email
        case premuimEnd = "premuim_end"
        case premuimType = "premuim_type"
        case photoLink = "photo_link"
        case fullName = "full_name"
        case gender, id
    }
}

