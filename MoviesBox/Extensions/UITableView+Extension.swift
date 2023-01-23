//
//  UITableView+Extension.swift
//  MoviesBox
//
//  Created by Anton Duda on 04.12.2022.
//

import UIKit

// MARK: - UITableView extension
extension UITableView {
    func dequeueCell<T: UITableViewCell>(_ type: T.Type, indexPath: IndexPath) -> T {
        return self.dequeueReusableCell(
            withIdentifier: type.identifier,
            for: indexPath) as! T
    }
    
    func registerCell<T: UITableViewCell>( _ type: T.Type) {
        self.register(type.nib, forCellReuseIdentifier: type.identifier)
    }
}
