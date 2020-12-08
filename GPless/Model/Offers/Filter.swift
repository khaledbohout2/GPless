//
//  Filter.swift
//  GPless
//
//  Created by Khaled Bohout on 11/19/20.
//

import Foundation

// MARK: - Filter
struct Filter: Codable {
    
    var categoryType, type, startPrice, mall: String?
    var endPrice: String?

    enum CodingKeys: String, CodingKey {
        case categoryType = "category_type"
        case type, mall
        case startPrice = "start_price"
        case endPrice = "end_price"
    }
}
