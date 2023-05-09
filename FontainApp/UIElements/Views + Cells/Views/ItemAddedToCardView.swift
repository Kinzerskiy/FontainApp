//
//  ItemAddedToCardView.swift
//  FontainApp
//
//  Created by Mac Pro on 12.04.2023.
//

import UIKit

class ItemAddedToCardView: UIView {

    
    @IBOutlet weak var addToCardView: UIView!
    @IBOutlet weak var viewButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        prepareView()
    }
    
    static func setup(in view: UIView) -> ItemAddedToCardView {
        let itemAddedToCardView = ItemAddedToCardView.loadFromNib()!
        itemAddedToCardView.frame = view.bounds
        view.addSubview(itemAddedToCardView)
        return itemAddedToCardView
    }
    
    func prepareView() {
        addToCardView?.layer.cornerRadius = 12
    }
    
  
    
    @IBAction func viewBuyAction(_ sender: Any) {
      
    }
    
    
}
