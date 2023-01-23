//
//  SearchResponse.swift
//  MoviesBox
//
//  Created by Anton Duda on 05.12.2022.
//

import Foundation

// MARK: - Welcome
struct SearchResponse: Codable {
    let results: [Result]
    let searchType,
        expression,
        errorMessage: String
}

// MARK: - Result
struct Result: Codable {
    let id,
        resultType,
        image,
        title,
        description: String
}
