//
//  Profile.swift
//  GPless
//
//  Created by Khaled Bohout on 11/30/20.
//

import Foundation


// MARK: - Profile
struct Profile: Codable {
    
    var accountName, premuimEnd, premuimType, photoLink: String?
    var rank, permuim, points: Int?

    enum CodingKeys: String, CodingKey {
        
        case accountName = "account_name"
        case points, rank, permuim
        case premuimEnd = "premuim_end"
        case premuimType = "premuim_type"
        case photoLink = "photo_link"
    }
}
