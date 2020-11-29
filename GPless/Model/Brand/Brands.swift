//
//  Brands.swift
//  GPless
//
//  Created by Khaled Bohout on 11/29/20.
//

import Foundation

// MARK: - Brands
struct Brands: Codable {
    
    var brands: [Brand]?
    var noOfPages, count: Int?

    enum CodingKeys: String, CodingKey {
        case brands
        case noOfPages = "no_of_pages"
        case count
    }
}

// MARK: - Brand
struct Brand: Codable {
    
    var id: Int?
    var fullName, accountName, phone, address: String?
    var loginMethod: String?
    var accountType: String?
    var verified, blocked: Int?
    var categoryTitle: String?
    var featured, premuim: Int?
    var promoCode: String?
    var premuimEnd, premuimType: String?
    var email: String?
    var photoLink, forgetPasswordCode, emailVerifiedAt, phoneType: String?
    var locationID: String?
    var createdAt, updatedAt: String?

    enum CodingKeys: String, CodingKey {
        case id
        case fullName = "full_name"
        case accountName = "account_name"
        case phone, address
        case loginMethod = "login_method"
        case accountType = "account_type"
        case verified, blocked
        case categoryTitle = "category_title"
        case featured, premuim
        case promoCode = "promo_code"
        case premuimEnd = "premuim_end"
        case premuimType = "premuim_type"
        case email
        case photoLink = "photo_link"
        case forgetPasswordCode = "forget_password_code"
        case emailVerifiedAt = "email_verified_at"
        case phoneType = "phone_type"
        case locationID = "location_id"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}
