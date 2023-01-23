//
//  MoviesResponse.swift
//  MoviesBox
//
//  Created by Anton Duda on 03.12.2022.
//

import Foundation

// MARK: - MoviesResponse
struct MoviesResponse: Codable {
    let items: [Item]
    let errorMessage: String
}

// MARK: - Item
struct Item: Codable {
    let id,
        rank,
        title,
        fullTitle,
        year,
        image,
        crew: String
}
