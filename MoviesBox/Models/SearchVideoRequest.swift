//
//  SearchVideoRequest.swift
//  MoviesBox
//
//  Created by Anton Duda on 07.12.2022.
//

import Foundation

// MARK: - SearchVideoRequest
struct SearchVideoRequest: NetworkRequest {
    typealias Response = SearchResponse
    
    // MARK: - Public properties
    var path: String { "SearchMovie" }
    var method: HTTPMethod { .get }
    var queryPath: String
    
    // MARK: - Life cycle
    init(queryPath: String) {
        self.queryPath = queryPath
    }
}
