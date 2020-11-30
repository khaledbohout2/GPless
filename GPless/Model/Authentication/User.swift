//
//  User.swift
//  GPless
//
//  Created by Khaled Bohout on 11/30/20.
//

import Foundation

// MARK: - User
struct User: Codable {
    var fullName, email, accountName, accountType: String?
    var address, loginMethod, phone, promoCode: String?
    var updatedAt, createdAt: String?
    var id: Int?
    var tokens: Tokens?
    var error: String?

    enum CodingKeys: String, CodingKey {
        case fullName = "full_name"
        case email
        case accountName = "account_name"
        case accountType = "account_type"
        case address
        case loginMethod = "login_method"
        case phone
        case promoCode = "promo_code"
        case updatedAt = "updated_at"
        case createdAt = "created_at"
        case id, tokens, error
    }
}

// MARK: - Tokens
struct Tokens: Codable {
    var tokenType: String?
    var expiresIn: Int?
    var accessToken, refreshToken: String?

    enum CodingKeys: String, CodingKey {
        case tokenType = "token_type"
        case expiresIn = "expires_in"
        case accessToken = "access_token"
        case refreshToken = "refresh_token"
    }
}
