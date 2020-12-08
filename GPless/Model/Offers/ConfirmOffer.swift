//
//  ConfirmOffer.swift
//  GPless
//
//  Created by Khaled Bohout on 12/7/20.
//

import Foundation

// MARK: - ConfirmOffer
struct ConfirmOffer: Codable {
    var ids: [Int]?
    var branchCode: String?

    enum CodingKeys: String, CodingKey {
        case ids = "Ids"
        case branchCode = "branch_code"
    }
}
