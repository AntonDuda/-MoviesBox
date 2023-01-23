//
//  GetImageRequest.swift
//  MoviesBox
//
//  Created by Anton Duda on 07.12.2022.
//

import Foundation

// MARK: - GetImageRequest
struct GetImageRequest: NetworkRequest {
    
    // MARK: - Public properties
    var path: String
    var method: HTTPMethod { .get }
    var queryPath: String { "" }
    
    // MARK: - Life cycle
    init(path: String) {
        self.path = path
    }
    
    // MARK: - Public methods
    func decode(_ data: Data) throws -> ImageResponse {
        return ImageResponse(data: data)
    }
    
    func prepareURL() -> URL? {
        return URL(string: path)
    }
}
