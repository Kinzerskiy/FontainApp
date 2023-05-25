//
//  OrderHistoryCollectionViewCell.swift
//  FontainApp
//
//  Created by Mac Pro on 25.05.2023.
//

import UIKit

class OrderHistoryCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var orderDate: UILabel!
    @IBOutlet weak var orderProductLabel: UILabel!
    @IBOutlet weak var orderTotalLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func fill(with model: Order) {
        
        let dateFormatter = DateFormatter()
        let stringDate = dateFormatter.string(from: model.orderCreated)
        
        orderDate.text = stringDate
        guard let products = model.products else { return }
        let names: [String] = products.map { product in
            return product.product.name
        }
        orderProductLabel.text = names.joined(separator: ",")
        orderTotalLabel.text = String(model.total ?? 0)
    }
}
