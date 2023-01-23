//
//  AppRouter.swift
//  MoviesBox
//
//  Created by Anton Duda on 04.12.2022.
//

import UIKit
import Foundation

// MARK: - AppRouterProtocol
protocol AppRouterProtocol: AnyObject {
    func showDetailsView(title: String, imageURL: String)
}

// MARK: - AppRouter
final class AppRouter {
    
    // MARK: - Public properties
    private var window: UIWindow
    private let navigation = UINavigationController()
    
    // MARK: - Life cicle
    init(window: UIWindow) {
        self.window = window
        self.window.rootViewController = navigation
        self.window.makeKeyAndVisible()
    }
    
    // MARK: - Public method
    func startApp() {
        showMoveListController()
    }
    
    // MARK: - Private Method
    private func showMoveListController() {
        let controller = MovieListViewController.instantiateFromStoryboard()
        let presenter = MovieListPresenter(view: controller, router: self)
        controller.presenter = presenter
        navigation.pushViewController(controller, animated: true)
    }
}

// MARK: - AppRouterProtocol implementation
extension AppRouter: AppRouterProtocol {
    func showDetailsView(title: String, imageURL: String) {
        let controller = MovieDetailsViewController.instantiateFromStoryboard()
        let presenter = MovieDetailsPresenter(view: controller, moviewTitle: title, imageStringURL: imageURL)
        controller.presenter = presenter
        navigation.pushViewController(controller, animated: true)
    }
}
