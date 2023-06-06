//
//  StoreInfoView.swift
//  FontainApp
//
//  Created by Mac Pro on 12.04.2023.
//

import UIKit

class StoreInfoView: UIView {

    @IBOutlet weak var storeName: UILabel!
    @IBOutlet weak var storeAddress: UILabel!
    @IBOutlet weak var storePhoto: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        prepareView()
    }
    
    static func setup(in view: UIView) -> StoreInfoView {
        let storeInfoView = StoreInfoView.loadFromNib()!
        storeInfoView.frame = view.bounds
        view.addSubview(storeInfoView)
        return storeInfoView
    }
    
    func configure(with location: Location) {
           storeName.text = location.storeName
           storeAddress.text = location.storeAddress
           // Set the store photo using location.storePhoto
       }
    
    
    func prepareView() {
        
    }
}
