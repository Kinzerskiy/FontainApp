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
    @IBOutlet weak var firstView: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        prepareView()
        
    }
    
    func fill(with product: Product) {
            productNameLabel.text = product.name
            productMeasureLabel.text = product.measure
            productPriceLabel.text = "\(product.price)"
            
            if let imageUrl = product.productImageUrl, let source = URL(string: imageUrl) {
                productImage.kf.setImage(with: source)
            }
        }
    
    func prepareView() {
        
        firstView.layer.borderWidth = 1
        firstView.layer.cornerRadius = 12
        firstView.layer.borderColor = UIColor(named: "Primary")?.cgColor
    }
}
