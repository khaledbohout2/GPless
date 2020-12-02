//
//  Notification.swift
//  GPless
//
//  Created by Khaled Bohout on 12/2/20.
//

import Foundation

// MARK: - Notifications
struct Notifications: Codable {
    var notifications: [Notification]?
    var noOfPages, count: Int?

    enum CodingKeys: String, CodingKey {
        case notifications
        case noOfPages = "no_of_pages"
        case count
    }
}

// MARK: - Notification
struct Notification: Codable {
    var id: Int?
    var title, type: String?
    var userID, seen: Int?
    var notificationDescription: String?
    var imageLink: String?
    var targetAudience, createdAt, updatedAt: String?

    enum CodingKeys: String, CodingKey {
        case id, title, type
        case userID = "user_id"
        case seen
        case notificationDescription = "description"
        case imageLink = "image_link"
        case targetAudience = "target_audience"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}
