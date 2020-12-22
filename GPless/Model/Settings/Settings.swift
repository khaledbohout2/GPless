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
    var iconsLink, notificationsLink: String?
    var sixMonthsMembershipFees, oneYearMembershipFees, topRatedStartDate, topRatedEndDate: String?
    var whatIsTodayLink, usersPhotoLink, categoriesLink, offersLink: String?
    var termsAndCondition, privacyPolicy: String?
    var faqs: Faqs?

    enum CodingKeys: String, CodingKey {
        
        case id
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case iconsLink = "icons_link"
        case notificationsLink = "notifications_link"
        case sixMonthsMembershipFees = "six_months_membership_fees"
        case oneYearMembershipFees = "one_year_membership_fees"
        case topRatedStartDate = "top_rated_start_date"
        case topRatedEndDate = "top_rated_end_date"
        case whatIsTodayLink = "what_is_today_link"
        case usersPhotoLink = "users_photo_link"
        case categoriesLink = "categories_link"
        case offersLink = "offers_link"
        case termsAndCondition = "terms_and_condition"
        case privacyPolicy = "privacy_policy"
        case faqs
    }
}

// MARK: - Faqs
struct Faqs: Codable {
    
    var whatIsGplessApplication, howToUseGplessApp, howToUseGplessLiveSupportTeam, howManyOffersCanIGetFree: [String]?
    var whatAreThePremiumAccountBenefits: [String]?

    enum CodingKeys: String, CodingKey {
        
        case whatIsGplessApplication = "What is Gpless application?"
        case howToUseGplessApp = "How to use Gpless app ?"
        case howToUseGplessLiveSupportTeam = "How to use Gpless’ live support team ?"
        case howManyOffersCanIGetFree = "How many offers can I get free?"
        case whatAreThePremiumAccountBenefits = "What are the premium account benefits ?"
    }
}
