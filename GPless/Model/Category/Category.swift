//
//  Category.swift
//  GPless
//
//  Created by Khaled Bohout on 11/19/20.
//


import Foundation

// MARK: - Category
struct Category: Codable {
    var categories: [CategoryElement]?
    var noOfPages, count: Int?

    enum CodingKeys: String, CodingKey {
        case categories
        case noOfPages = "no_of_pages"
        case count
    }
}

// MARK: - CategoryElement
struct CategoryElement: Codable {
    var categoryName: String?
    var subCategories: [String]?
    var photoLink: String?

    enum CodingKeys: String, CodingKey {
        case categoryName = "category_name"
        case subCategories = "sub_categories"
        case photoLink = "photo_link"
    }
}

