//
//  MovieListViewModel.swift
//  MoviesBox
//
//  Created by Anton Duda on 06.12.2022.
//

import UIKit
import Foundation

// MARK: - MovieListViewModel
struct MovieListViewModel {
    
    // MARK: Properties
    let rank: String
    let title: String
    let imageString: String
    
    // MARK: - Life cycle
    init(rank: String, title: String, imageString: String) {
        self.rank = rank
        self.title = title
        self.imageString = imageString
    }
    
}
