//
//  Profile.swift
//  GPless
//
//  Created by Khaled Bohout on 11/30/20.
//

import Foundation

import Foundation

// MARK: - Profile
struct Profile: Codable {
    var accountName, accountType, address: String?
    var blocked: Int?
    var categoryTitle, createdAt, email, emailVerifiedAt: String?
    var featured: Int?
    var forgetPasswordCode, fullName: String?
    var id: Int?
    var locationID, loginMethod: String?
    var phone: Int?
    var phoneType, photoLink: String?
    var premuim: Int?
    var premuimEnd, premuimType, promoCode, updatedAt: String?
    var verified: Int?

    enum CodingKeys: String, CodingKey {
        case accountName = "account_name"
        case accountType = "account_type"
        case address, blocked
        case categoryTitle = "category_title"
        case createdAt = "created_at"
        case email
        case emailVerifiedAt = "email_verified_at"
        case featured
        case forgetPasswordCode = "forget_password_code"
        case fullName = "full_name"
        case id
        case locationID = "location_id"
        case loginMethod = "login_method"
        case phone
        case phoneType = "phone_type"
        case photoLink = "photo_link"
        case premuim
        case premuimEnd = "premuim_end"
        case premuimType = "premuim_type"
        case promoCode = "promo_code"
        case updatedAt = "updated_at"
        case verified
    }
}
