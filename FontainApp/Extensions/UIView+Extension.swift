//
//  UIView+Extension.swift
//  FontainApp
//
//  Created by Mac Pro on 15.04.2023.
//

import Foundation

import UIKit

@objc protocol NibLoadableView: AnyObject {
    
}

extension NibLoadableView where Self: UIView {
    
    static var nibName: String {
        return NSStringFromClass(self).components(separatedBy: ".").last!
    }
    
    static func loadFromNib() -> Self? {
        return UINib.init(nibName: nibName, bundle: nil).instantiate(withOwner: nil, options: nil).first as? Self
    }
    
    static func getNib() -> UINib {
        return  .init(nibName: String(describing: self.self), bundle: nil)
    }
    
    static func reusableIdentifier() -> String {
        return String(describing: self.self)
    }
}

@objc protocol ReusableView: AnyObject {}

extension ReusableView where Self: UIView {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}

extension UIView: NibLoadableView {}
