//
//  OfferModel.swift
//  GPless
//
//  Created by Khaled Bohout on 11/19/20.
//

import Foundation

struct OfferModel: Codable {
    
    var id: Int?
    var name, offerDetailsDescription, type, duration: String?
    var discount, priceBeforeDiscount, priceAfterDiscount: Int?
    var categoryType: String?
    var points: Int?
    var imageLink: String?
    var userUsage, offerUsage, approved, promoted: Int?
    var premuimPaid, vendorPercent, adminPercent, vendorID: Int?
    var deletedAt: String?
    var createdAt, updatedAt: String?
    var userRate: Int?
    var avgRate: Int?
    var vendorName, remainingTime: String?
    var reviews: Int?
    var expiredAt: String?

    enum CodingKeys: String, CodingKey {
        case id, name
        case offerDetailsDescription = "description"
        case type, duration, discount
        case priceBeforeDiscount = "price_before_discount"
        case priceAfterDiscount = "price_after_discount"
        case categoryType = "category_type"
        case points
        case imageLink = "image_link"
        case userUsage = "user_usage"
        case offerUsage = "offer_usage"
        case approved, promoted
        case premuimPaid = "premuim_paid"
        case vendorPercent = "vendor_percent"
        case adminPercent = "admin_percent"
        case vendorID = "vendor_id"
        case deletedAt = "deleted_at"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case avgRate = "avg_rate"
        case userRate = "user_rate"
        case vendorName = "vendor_name"
        case remainingTime = "remaining_time"
        case reviews
        case expiredAt = "expired_at"
    }
}
