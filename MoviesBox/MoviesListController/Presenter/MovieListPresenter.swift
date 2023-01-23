//
//  MovieListPresenter.swift
//  MoviesBox
//
//  Created by Anton Duda on 04.12.2022.
//

import Foundation
import UIKit

// MARK: - MovieListPresenterProtocol
protocol MovieListPresenterProtocol: AnyObject {
    var dataList: [MovieListViewModel] { get }
    
    func viewLoaded()
    func selectFilm(at index: Int)
    func searchMovie(string: String)
}

// MARK: - MovieListPresenter
final class MovieListPresenter: ServiceResolverProtocol {
    
    // MARK: - Private property
    private unowned let view: MovieListViewProtocol
    private lazy var networkService = resolveService(type: NetworkService.self)
    private var debounceTimer: Timer?
    private var router: AppRouterProtocol
    private var moviesList: [Item] = []
    private var searchList: [Result] = []
    
    // MARK: - Public property
    private(set) var dataList: [MovieListViewModel] = [] {
        didSet {
            view.reloadTableView()
        }
    }
    
    // MARK: - Life cycle
    init(view: MovieListViewProtocol, router: AppRouterProtocol) {
        self.view = view
        self.router = router
    }
    
    deinit {
        debounceTimer?.invalidate()
        debounceTimer = nil
    }
    
    //MARK: Private methods
    private func reloadDataSource() {
        dataList = searchList.isEmpty ? mapMoviesList() : mapSearchResults()
    }
    
    private func mapSearchResults() -> [MovieListViewModel] {
        searchList.compactMap { .init(rank: "", title: $0.title, imageString: $0.image) }
    }
    
    private func mapMoviesList() -> [MovieListViewModel] {
        moviesList.compactMap { .init(rank: $0.rank, title: $0.title, imageString: $0.image) }
    }
}


// MARK: - MovieListPresenterProtocol implementation
extension MovieListPresenter: MovieListPresenterProtocol {
    func viewLoaded() {
        getMoviesList()
        view.setupUI()
    }
    
    func selectFilm(at index: Int) {
        let selectedMovie = dataList[index]
        router.showDetailsView(title: selectedMovie.title, imageURL: selectedMovie.imageString)
    }
    
    func searchMovie(string: String) {
        debounceTimer?.invalidate()
        debounceTimer = Timer.scheduledTimer(withTimeInterval: 0.3, repeats: false, block: { [weak self] _ in
            self?.performSearch(string: string)
        })
    }
    
    // MARK: Private methods
    private func performSearch(string: String) {
        guard !string.isEmpty else {
            searchList.removeAll()
            reloadDataSource()
            return
        }
        
        let searchRequest = SearchVideoRequest(queryPath: string)
        networkService?.performRequest(request: searchRequest) { [weak self] response, error in
            guard let self = self, let searchList = response?.results else { return }
            
            DispatchQueue.main.async {
                self.searchList = searchList
                self.reloadDataSource()
            }
        }
    }
    
    private func getMoviesList() {
        networkService?.performRequest(request: GetVideoListRequest()) { [weak self] response, error in
            guard let self = self, let response = response else { return }
            
            DispatchQueue.main.async() {
                self.moviesList = response.items
                self.reloadDataSource()
            }
        }
    }
}
