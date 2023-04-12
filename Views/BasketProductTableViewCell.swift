//
//  BasketProductTableViewCell.swift
//  FontainApp
//
//  Created by Mac Pro on 12.04.2023.
//

import UIKit

class BasketProductTableViewCell: UITableViewCell {
    
    @IBOutlet weak var basketProductImage: UIImageView!
    @IBOutlet weak var basketProductName: UILabel!
    @IBOutlet weak var basketProductCost: UILabel!
    @IBOutlet weak var basketProductMeasure: UILabel!
    
    @IBOutlet weak var minusProductButton: UIButton!
    @IBOutlet weak var plusProductButton: UIButton!
    @IBOutlet weak var countLabel: UILabel!
    
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
