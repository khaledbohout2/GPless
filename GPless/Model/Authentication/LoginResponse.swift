//
//  LoginResponse.swift
//  GPless
//
//  Created by Khaled Bohout on 12/21/20.
//


import Foundation

// MARK: - LoginResponse
struct LoginResponse: Codable {
    
    var token: String?
    var permuim: Int?
    var id: Int?

}
