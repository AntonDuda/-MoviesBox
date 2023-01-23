//
//  MovieDetailsPresenter.swift
//  MoviesBox
//
//  Created by Anton Duda on 05.12.2022.
//

import Foundation
// MARK: - MovieDetailsProtocol
protocol MovieDetailsProtocol: AnyObject {
    func viewLoaded()
}

// MARK: - MovieDetailsPresenter
final class MovieDetailsPresenter {
    
    // MARK: - Private property
    private unowned let view: MovieDetailsViewProtocol
    private let moviewTitle: String
    private let imageStringURL: String
    
    // MARK: - Life cycle
    init(view: MovieDetailsViewProtocol,
         moviewTitle: String,
         imageStringURL: String) {
        self.view = view
        self.moviewTitle = moviewTitle
        self.imageStringURL = imageStringURL
    }
}

// MARK: - MovieDetailsProtocol implementation
extension MovieDetailsPresenter: MovieDetailsProtocol {
    func viewLoaded() {
        view.setupUI(with: moviewTitle, imageURL: imageStringURL)
    }
}
