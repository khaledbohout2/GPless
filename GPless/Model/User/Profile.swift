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
    var points, rank, permuim: Int?
    var premuimType, premuimEnd: String?
    var id: Int?
    var gender: String?
    var email: String?
    var photoLink: String?
    var fullName: String?

    enum CodingKeys: String, CodingKey {
        case accountName = "account_name"
        case points, rank, permuim
        case premuimType = "premuim_type"
        case premuimEnd = "premuim_end"
        case id, gender, email
        case photoLink = "photo_link"
        case fullName = "full_name"
    }
}

