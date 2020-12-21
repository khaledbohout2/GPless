//
//  LoginResponse.swift
//  GPless
//
//  Created by Khaled Bohout on 12/21/20.
//


import Foundation

// MARK: - LoginResponse
struct LoginResponse: Codable {
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
