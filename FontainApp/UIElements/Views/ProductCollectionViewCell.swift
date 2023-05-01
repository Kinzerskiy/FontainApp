//
//  ProductCollectionViewCell.swift
//  FontainApp
//
//  Created by Mac Pro on 12.04.2023.
//

import UIKit

class ProductCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var productMeasureLabel: UILabel!
    @IBOutlet weak var productCostLabel: UILabel!
    @IBOutlet weak var productImageLabel: UIImageView!
    
    @IBOutlet weak var buyView: UIView!
    @IBOutlet weak var buyButton: UIButton!
    
    var buyComplition: (() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        prepareUI()
    }
    
    func fill (with model: Product) {
        productNameLabel.text = model.name
        productMeasureLabel.text = model.measure
        productCostLabel.text = "€" + String(model.price)
        productImageLabel.image = UIImage(named: model.imageName)
        
    }
    
    func prepareUI() {
        buyView.layer.cornerRadius = buyView.frame.size.width / 2
        buyView.clipsToBounds = true
    }
    
    @IBAction func buyButtonPressed(_ sender: Any) {
        buyComplition?()
    }
    
}
