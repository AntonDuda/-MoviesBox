//
//  NetworkRequests.swift
//  MoviesBox
//
//  Created by Anton Duda on 04.12.2022.
//

import Foundation

// MARK: - HTTPMethod enum
enum HTTPMethod: String {
    case get = "GET"
}

// MARK: - NetworkRequest protocol
protocol NetworkRequest {
    associatedtype Response
    
    // MARK: - Public properties
    var path: String { get }
    var method: HTTPMethod { get }
    var queryPath: String { get }
    
    // MARK: - Public methods
    func prepareURL() -> URL?
    func decode(_ data: Data) throws -> Response
}

// MARK: - NetworkRequest extension
extension NetworkRequest where Response: Decodable {
    
    // MARK: - Public methods
    func prepareURL() -> URL? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "imdb-api.com"
        components.path = "/en/API/\(path)/\("k_x7y8b6q4")/\(queryPath)"
        return components.url
    }
    
    func decode(_ data: Data) throws -> Response {
        let decoder = JSONDecoder()
        return try decoder.decode(Response.self, from: data)
    }
}
