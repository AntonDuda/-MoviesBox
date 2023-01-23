//
//  ImageCachingService.swift
//  MoviesBox
//
//  Created by Anton Duda on 04.12.2022.
//

import UIKit

// MARK: - ImageCachingService Protocol
protocol ImageCachingService {
    func imageWithUrl(_ url: String) -> UIImage?
    func loadImage(_ url: String, completion: @escaping (UIImage?, String) -> Void)
}

//MARK: ImageCachingManager
final class ImageCachingManager: ImageCachingService {
    
    //MARK: Private properties
    private let networkService: NetworkService
    private let imageCache = NSCache<AnyObject, AnyObject>()
    
    //MARK: Life cycle
    init(networkService: NetworkService) {
        self.networkService = networkService
    }
    
    // MARK: - Public methods
    func imageWithUrl(_ url: String) -> UIImage? {
        imageCache.object(forKey: url as AnyObject) as? UIImage
    }
    
    func loadImage(_ url: String, completion: @escaping (UIImage?, String) -> Void) {
        let request = GetImageRequest(path: url)
        networkService.performRequest(request: request) { [weak self] response, _ in
            guard let imageToCache = response?.image, let self = self else {
                completion(nil, url)
                return
            }
            self.imageCache.setObject(imageToCache, forKey: url as AnyObject)
            completion(imageToCache, url)
        }
    }
}


