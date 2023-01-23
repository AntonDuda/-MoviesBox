//
//  ImageResponse.swift
//  MoviesBox
//
//  Created by Anton Duda on 03.12.2022.
//

import UIKit

// MARK: - ImageResponse
struct ImageResponse {
    
    // MARK: - Public property
    var image: UIImage?
    
    // MARK: - Life cycle
    init(data: Data) {
        self.image = UIImage(data: data)
    }
}
