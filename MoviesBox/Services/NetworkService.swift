//
//  NetworkService.swift
//  MoviesBox
//
//  Created by Anton Duda on 04.12.2022.
//

import Foundation

// MARK: - NetworkService Protocol
protocol NetworkService {
    func performRequest<Request: NetworkRequest>(request: Request, completion: @escaping (Request.Response?, Error?) -> Void)
}

// MARK: - NetworkManager
final class NetworkManager: NetworkService {
    
    //MARK: NetworkService
    func performRequest<Request: NetworkRequest>(request: Request, completion: @escaping (Request.Response?, Error?) -> Void) {
        guard let url = request.prepareURL() else {
            completion(nil, nil)
            return
        }
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else { return }
            do {
                let response = try request.decode(data)
                
                DispatchQueue.main.async() {
                    completion(response, nil)
                }
            }
            catch {
                DispatchQueue.main.async() {
                    completion(nil, error)
                }
            }
        }.resume()
    }
}
