//
//  GetVideoRequest.swift
//  MoviesBox
//
//  Created by Anton Duda on 07.12.2022.
//

import Foundation

// MARK: - GetVideoListRequest
struct GetVideoListRequest: NetworkRequest {
    typealias Response = MoviesResponse
    
    // MARK: - Public properties
    var path: String { "Top250Movies" }
    var method: HTTPMethod { .get }
    var queryPath: String { "" }
}
