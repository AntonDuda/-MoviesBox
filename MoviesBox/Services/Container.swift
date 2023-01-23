//
//  Container.swift
//  MoviesBox
//
//  Created by Anton Duda on 04.12.2022.
//

import Foundation

// MARK: - Container
class Container {
    
    // MARK: - Public property
    static let shared = Container()
    
    // MARK: - Private method
    private lazy var reg: Dictionary<String, Any> = [:]
    
    // MARK: - Private init
    private init() {}
    
    // MARK: - Public methods
    func addService<T>(type: T.Type, service: T) {
        let key = String(describing: type.self)
        reg[key] = service
    }

    func resolveService<T>(type: T.Type) -> T? {
        let key = String(describing: type.self)
        return reg[key] as? T
    }
}

// MARK: - ServiceResolverProtocol
protocol ServiceResolverProtocol {
    func resolveService<T>(type: T.Type) -> T?
}

// MARK: - ServiceResolverProtocol extension
extension ServiceResolverProtocol {
    func resolveService<T>(type: T.Type) -> T? {
        return Container.shared.resolveService(type: type)
    }
}
