//
//  UIImageView+Extension.swift
//  MoviesBox
//
//  Created by Anton Duda on 06.12.2022.
//

import UIKit

// MARK: - UIImageView extension
extension UIImageView: ServiceResolverProtocol {
    func loadImageWithUrl(_ url: String) {
        guard let service = resolveService(type: ImageCachingService.self) else { return }
        
        if let image = service.imageWithUrl(url) {
            self.image = image
        } else {
            self.image = nil
            service.loadImage(url, completion: { [weak self] image, imageURL in
                if let self = self, url == imageURL {
                    self.image = image
                }
            })
        }
    }
}
