//
//  User.swift
//  GPless
//
//  Created by Khaled Bohout on 11/19/20.
//

import Foundation

// MARK: - User
struct User: Codable {
    var fullName, accountName, accountType, phone: String?
    var address, loginMethod, account, email: String?
    var tokens: Tokens?

    enum CodingKeys: String, CodingKey {
        case fullName = "full_name"
        case accountName = "account_name"
        case accountType = "account_type"
        case phone, address
        case loginMethod = "login_method"
        case account, email, tokens
    }
}

// MARK: - Tokens
struct Tokens: Codable {
}
