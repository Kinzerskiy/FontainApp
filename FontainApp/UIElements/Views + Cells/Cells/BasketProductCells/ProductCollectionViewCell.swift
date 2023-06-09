//
//  ProductCollectionViewCell.swift
//  FontainApp
//
//  Created by Mac Pro on 12.04.2023.
//

import UIKit

class ProductCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var firstView: UIView!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var productMeasureLabel: UILabel!
    @IBOutlet weak var productCostLabel: UILabel!
    @IBOutlet weak var productImageView: UIImageView!
    
    @IBOutlet weak var buyView: UIView!
    @IBOutlet weak var buyButton: UIButton!
    
    var buyComplition: (() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        prepareUI()
    }
  
    
    func fill(with model: Product) {
        
        guard let imageUrl = model.productImageUrl, let source = URL.init(string: imageUrl) else { return }
        
        productImageView.kf.setImage(with: source)
        productNameLabel.text = model.name
        productMeasureLabel.text = model.measure
        productCostLabel.text = "€" + String(model.price)
    }
    
    func prepareUI() {
        
        firstView.layer.cornerRadius = 12
        
        buyButton.layer.cornerRadius = buyButton.frame.size.width / 2
        buyButton.clipsToBounds = true
        
        buyView.layer.cornerRadius = buyView.frame.size.width / 2
        buyView.clipsToBounds = true
    }
    
    @IBAction func buyButtonPressed(_ sender: Any) {
        buyComplition?()
    }
}
