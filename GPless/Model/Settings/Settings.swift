//
//  Settings.swift
//  GPless
//
//  Created by Khaled Bohout on 12/3/20.
//

import Foundation

// MARK: - Settings
struct Settings: Codable {
    var id: Int?
    var createdAt, updatedAt: String?
    var iconsLink, notificationsLink, whatIsTodayLink, usersPhotoLink: String?
    var categoriesLink, offersLink: String?
    var termsAndCondition, privacyPolicy, faqs: String?

    enum CodingKeys: String, CodingKey {
        case id
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case iconsLink = "icons_link"
        case notificationsLink = "notifications_link"
        case whatIsTodayLink = "what_is_today_link"
        case usersPhotoLink = "users_photo_link"
        case categoriesLink = "categories_link"
        case offersLink = "offers_link"
        case termsAndCondition = "terms_and_condition"
        case privacyPolicy = "privacy_policy"
        case faqs
    }
}
