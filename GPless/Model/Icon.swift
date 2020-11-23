//
//  Icon.swift
//  GPless
//
//  Created by Khaled Bohout on 11/22/20.
//

// MARK: - Icon
struct Icon: Codable {
    var photoName, photoPath: String?

    enum CodingKeys: String, CodingKey {
        case photoName = "photo_name"
        case photoPath = "photo_path"
    }
}
