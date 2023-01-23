//
//  FilmCell.swift
//  MoviesBox
//
//  Created by Anton Duda on 04.12.2022.
//

import UIKit

// MARK: - FilmCell
final class FilmCell: UITableViewCell {
    
    // MARK: - IBOutlets
    @IBOutlet private weak var filmImageView: UIImageView!
    @IBOutlet private weak var filmRateLabel: UILabel!
    @IBOutlet private weak var filmTitleLabel: UILabel!
    @IBOutlet private weak var movieBackgroundView: UIView!
    
    // MARK: - Life cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        configureUI()
    }
    
    // MARK: - Private method
    private func configureUI() {
        movieBackgroundView.layer.cornerRadius = 12
    }
    
    // MARK: - Public method
    func configureCell(with model: MovieListViewModel) {
        filmImageView.loadImageWithUrl(model.imageString)
        filmTitleLabel.text = model.title
        filmRateLabel.text = model.rank
    }
}
