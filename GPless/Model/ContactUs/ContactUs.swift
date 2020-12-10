//
//  ContactUs.swift
//  GPless
//
//  Created by Khaled Bohout on 12/2/20.
//

import Foundation


// MARK: - ContactUS
struct ContactUS: Codable {
    
    var messages: [Message]?
    var noOfPages, count: Int?

    enum CodingKeys: String, CodingKey {
        
        case messages
        case noOfPages = "no_of_pages"
        case count
    }
}

// MARK: - Message
struct Message: Codable {
    var id: Int?
    var title, name, email, phone: String?
    var userID: Int?
    var messageDescription, response: String?
    var createdAt: String?
    var updatedAt: String?

    enum CodingKeys: String, CodingKey {
        case id, title, name, email, phone
        case userID = "user_id"
        case messageDescription = "description"
        case response
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}
