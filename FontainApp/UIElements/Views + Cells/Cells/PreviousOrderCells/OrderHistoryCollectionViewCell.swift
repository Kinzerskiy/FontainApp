//
//  OrderHistoryCollectionViewCell.swift
//  FontainApp
//
//  Created by Mac Pro on 25.05.2023.
//

import UIKit

class OrderHistoryCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var firstView: UIView!
    @IBOutlet weak var orderDate: UILabel!
    @IBOutlet weak var orderProductLabel: UILabel!
    @IBOutlet weak var orderTotalLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        prepareUI()
    }
    
    
    func prepareUI() {
        firstView.layer.borderWidth = 1
        firstView.layer.cornerRadius = 12
        firstView.layer.borderColor = UIColor(named: "Primary")?.cgColor
    }
    
    
    
    func fill(with model: Order) {
        
        let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd.MM.YYYY, HH:mm"
        let stringDate = dateFormatter.string(from: model.orderCreated)
            orderDate.text = stringDate
            
        if let products = model.products {
                let productNames = products.compactMap { $0.product.name }
                print("productNames: \(productNames)")
                
                orderProductLabel.text = productNames.joined(separator: ",")
                   } else {
                       print("model.products is nil") // Debug print
                   }
            
            if let total = model.total {
                orderTotalLabel.text = String(format: "%.2f", total)
            } else {
                orderTotalLabel.text = "N/A"
            }
    }
}
