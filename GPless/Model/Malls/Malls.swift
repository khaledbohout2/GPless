//
//  Malls.swift
//  GPless
//
//  Created by Khaled Bohout on 12/2/20.
//

import Foundation

// MARK: - Malls
struct Malls: Codable {
    var malls: [Mall]?
    var noOfPages, count: Int?

    enum CodingKeys: String, CodingKey {
        case malls
        case noOfPages = "no_of_pages"
        case count
    }
}

// MARK: - Mall
struct Mall: Codable {
    var id: Int?
    var name, longitude, latitude, city: String?
    var address, phone, createdAt, updatedAt: String?

    enum CodingKeys: String, CodingKey {
        case id, name, longitude, latitude, city, address, phone
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}
