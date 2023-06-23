//
//  TotalTableViewCell.swift
//  FontainApp
//
//  Created by Mac Pro on 08.05.2023.
//

import UIKit

class TotalTableViewCell: UITableViewCell {

    @IBOutlet weak var priceLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }
    
    func fill(with model: OrderTotalViewModel) {
            priceLabel.text = "€" + String(format: "%.2f", model.total)
    }

}
