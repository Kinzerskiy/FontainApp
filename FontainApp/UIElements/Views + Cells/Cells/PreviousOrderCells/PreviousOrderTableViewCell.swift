//
//  PreviosOrderTableViewCell.swift
//  FontainApp
//
//  Created by Mac Pro on 26.05.2023.
//

import UIKit

class PreviousOrderTableViewCell: UITableViewCell {
    
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var productMeasureLabel: UILabel!
    @IBOutlet weak var productPriceLabel: UILabel!
    
    @IBOutlet weak var productCountLabel: UILabel!
    @IBOutlet weak var imageContainerView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        prepareUI()
        
    }
    
    func fill(with model: BasketProduct) {
        productNameLabel.text = model.product.name
        productMeasureLabel.text = model.product.measure
        productPriceLabel.text = "€ \(model.product.price)"
        productCountLabel.text = String(model.count) + " items"
        
        
        
        if let imageUrl = model.product.productImageUrl, let source = URL(string: imageUrl) {
                productImage.kf.setImage(with: source)
            }
        }
    
    func prepareUI() {
        selectionStyle = .none
        
        imageContainerView.layer.cornerRadius = 12
        imageContainerView.layer.borderWidth = 1
        imageContainerView.layer.borderColor = UIColor(named: "Primary")?.cgColor
        imageContainerView.clipsToBounds = true
    }
}
