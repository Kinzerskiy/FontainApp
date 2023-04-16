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
        layer.cornerRadius = 12
        backgroundColor = UIColor.init(named: "Secondary")
        setTitleColor(UIColor.white, for: .normal)
    }
    
    func unactiveStyle() {
        layer.cornerRadius = 12
        backgroundColor = .lightGray
        setTitleColor(UIColor.white, for: .normal)
    }
    
    func transperentRed() {
        layer.cornerRadius = 12
        
        backgroundColor = .white
        
        setTitleColor(UIColor.red, for: .normal)
        layer.borderWidth = 1
        layer.borderColor = UIColor.red.cgColor
        
    }
}




