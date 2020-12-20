//
//  UserToRegister.swift
//  GPless
//
//  Created by Khaled Bohout on 11/19/20.
//

import Foundation

import Foundation

// MARK: - UserToRegister
struct UserToRegister: Codable {
    
    var fullName, accountName, accountType, phone: String?
    var address, loginMethod, email, photoLink: String?
    var password, passwordConfirmation: String?

    enum CodingKeys: String, CodingKey {
        case fullName = "full_name"
        case accountName = "account_name"
        case accountType = "account_type"
        case phone, address
        case loginMethod = "login_method"
        case email
        case photoLink = "photo_link"
        case password
        case passwordConfirmation = "password_confirmation"
    }
}

// MARK: - UpgradeToPremium
struct UpgradeToPremium: Codable {
    
    var premuim = "1"
    var premuimType: String


    enum CodingKeys: String, CodingKey {
        case premuimType = "premuim_type"
        case premuim

    }
}


