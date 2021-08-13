//
//  RatingModel.swift
//  MovieLibrary
//
//  Created by abimanyu on 13/08/21.
//

import Foundation

// MARK: - Rating
struct Rating: Codable {
    let source, value: String

    enum CodingKeys: String, CodingKey {
        case source = "Source"
        case value = "Value"
    }
}
