//
//  MovieDetailsViewController.swift
//  MoviesBox
//
//  Created by Anton Duda on 05.12.2022.
//

import UIKit
// MARK: - MovieDetailsViewProtocol
protocol MovieDetailsViewProtocol: AnyObject {
    func setupUI(with title: String, imageURL: String)
}

// MARK: - MovieDetailsViewController
final class MovieDetailsViewController: UIViewController {
    
    // MARK: - IBOutlet
    @IBOutlet private weak var movieTitleLabel: UILabel!
    @IBOutlet private weak var movieImageView: UIImageView!
    
    // MARK: - Public property
    var presenter: MovieDetailsProtocol!
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewLoaded()
    }
}

// MARK: - MovieDetailsViewProtocol implementation
extension MovieDetailsViewController: MovieDetailsViewProtocol {
    func setupUI(with title: String, imageURL: String) {
        movieImageView.loadImageWithUrl(imageURL)
        movieTitleLabel.text = title
    }
}
