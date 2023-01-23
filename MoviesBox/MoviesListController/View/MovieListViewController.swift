//
//  MovieListViewController.swift
//  MoviesBox
//
//  Created by Anton Duda on 04.12.2022.
//

import UIKit

// MARK: - MovieListViewProtocol
protocol MovieListViewProtocol: AnyObject {
    func setupUI()
    func reloadTableView()
}

// MARK: - MovieListViewController
final class MovieListViewController: UIViewController {
    
    // MARK: - IBOutlet
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var searchBar: UISearchBar!
    
    // MARK: - Public property
    var presenter: MovieListPresenterProtocol!
    
    // MARK: - Private propery
    private let activityIndicator = UIActivityIndicatorView()
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewLoaded()
    }
    
    // MARK: - Private method
    private func registerCell() {
        tableView.registerCell(FilmCell.self)
    }
    
    private func configureActivityIndicatory() {
        activityIndicator.style = .large
        activityIndicator.color = .white
        activityIndicator.center = self.view.center
        self.view.addSubview(activityIndicator)
    }
}

// MARK: - MovieListViewProtocol implementation
extension MovieListViewController: MovieListViewProtocol {
    func setupUI() {
        title = "Movies"
        registerCell()
        searchBar.delegate = self
        navigationItem.hidesBackButton = true
        configureActivityIndicatory()
    }
    
    func reloadTableView() {
        tableView.reloadData()
        tableView.scrollToRow(at: .init(row: 0, section: 0), at: .top, animated: false)
    }
}

// MARK: - UITableViewDelegate implementation
extension MovieListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.selectFilm(at: indexPath.row)
    }
}

// MARK: - UITableViewDataSource implementation
extension MovieListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.dataList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueCell(FilmCell.self, indexPath: indexPath)
        cell.configureCell(with: presenter.dataList[indexPath.row])
        activityIndicator.stopAnimating()
        return cell
    }
}

// MARK: - UISearchBarDelegate implementation
extension MovieListViewController: UISearchBarDelegate {
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        presenter.searchMovie(string: searchBar.text ?? "")
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        activityIndicator.startAnimating()
    }
}
