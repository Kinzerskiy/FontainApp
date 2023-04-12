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
    @IBOutlet weak var productButtonLabel: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

}
