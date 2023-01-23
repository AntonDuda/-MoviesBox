//
//  UIView+NibRepresentable.swift
//  MoviesBox
//
//  Created by Anton Duda on 04.12.2022.
//

import UIKit
import Foundation

// MARK: - NibRepresentable protocol
protocol NibRepresentable {
    static var nib: UINib { get }
    static var identifier: String { get }
}

// MARK: - UIView extention
extension UIView: NibRepresentable {
    class var nib: UINib {
        return UINib(nibName: identifier, bundle: nil)
    }

    class var identifier: String {
        return String(describing: self)
    }
}

// MARK: - NibRepresentable extension
extension NibRepresentable where Self: UIView {
    static var viewFromNib: Self {
        return Bundle.main.loadNibNamed(
            Self.identifier,
            owner: nil, options: nil)?.first as! Self
    }
}

// MARK: - UIViewController extension
extension UIViewController: NibRepresentable {
    class var nib: UINib {
        return UINib(nibName: identifier, bundle: nil)
    }

    class var identifier: String {
        return String(describing: self)
    }
    
    static func loadFromNib() -> Self {
        func instantiateFromNib<T: UIViewController>() -> T {
            return T.init(nibName: String(describing: T.self), bundle: nil)
        }

        return instantiateFromNib()
    }
}

// MARK: - StoryboardInstantiatable protocol
protocol StoryboardInstantiatable {}

// MARK: - UIViewController extension
extension UIViewController: StoryboardInstantiatable {}

// MARK: - StoryboardInstantiatable extension
extension StoryboardInstantiatable where Self: NibRepresentable {
    static func instantiateFromStoryboard(name: String = Self.identifier) -> Self {
        let storyboard = UIStoryboard(name: name, bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: Self.identifier)
        return vc as! Self
    }
}

// MARK: - ViewControllerRepresentable protocol
protocol ViewControllerRepresentable: AnyObject {
    var view: UIView! { get }
}

// MARK: - UIViewController extension
extension UIViewController: ViewControllerRepresentable {}

// MARK: - UIStoryboard extension
extension UIStoryboard {
    var identifier: String {
        return String(describing: self)
    }
}
