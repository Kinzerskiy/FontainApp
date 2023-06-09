//
//  UIButtons.swift
//  FontainApp
//
//  Created by Mac Pro on 07.04.2023.
//

import Foundation
import UIKit

extension UIButton {
    
    func activeStyle() {
        layer.cornerRadius = frame.height / 2
        backgroundColor = UIColor.init(named: "Primary")
        setTitleColor(UIColor.white, for: .normal)
    }
    
    func unactiveStyle() {
        layer.cornerRadius = frame.height / 2
        backgroundColor = .lightGray
        setTitleColor(UIColor.white, for: .normal)
    }
    
    func transperentRed() {
        layer.cornerRadius = frame.height / 2
        backgroundColor = .white
        setTitleColor(UIColor.red, for: .normal)
        layer.borderWidth = 1
        layer.borderColor = UIColor.red.cgColor
        
    }
}

extension UIView {
    func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(
            roundedRect: bounds,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        let maskLayer = CAShapeLayer()
        maskLayer.path = path.cgPath
        layer.mask = maskLayer
    }
}
