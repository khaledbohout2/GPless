//
//  OfferModel.swift
//  GPless
//
//  Created by Khaled Bohout on 11/19/20.
//

import Foundation

struct OfferModel: Codable {
    
    var name, offerModelDescription, discount, priceBeforeDiscount: String?
    var priceAfterDiscount, categoryType: String?
    var branchesName: [String]?
    var points, imageLink, usage, vendorName: String?

    enum CodingKeys: String, CodingKey {
        case name
        case offerModelDescription = "description"
        case discount
        case priceBeforeDiscount = "price_before_discount"
        case priceAfterDiscount = "price_after_discount"
        case categoryType = "category_type"
        case branchesName = "branches_name"
        case points
        case imageLink = "image_link"
        case usage
        case vendorName = "vendor_name"
    }
}
