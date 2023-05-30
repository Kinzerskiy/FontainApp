//
//  StoreInfoView.swift
//  FontainApp
//
//  Created by Mac Pro on 12.04.2023.
//

import UIKit

class StoreInfoView: UIView {

    
    static func setup(in view: UIView) -> StoreInfoView {
        let storeInfoView = StoreInfoView.loadFromNib()!
        storeInfoView.frame = view.bounds
        view.addSubview(storeInfoView)
        return storeInfoView
    }
    
    
    func prepareView() {
        
    }
}
