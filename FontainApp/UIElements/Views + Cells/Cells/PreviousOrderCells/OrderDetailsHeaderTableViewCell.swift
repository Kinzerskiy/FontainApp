//
//  OrderDetailsHeaderTableViewCell.swift
//  FontainApp
//
//  Created by Mac Pro on 26.05.2023.
//

import UIKit

class OrderDetailsHeaderTableViewCell: UITableViewCell {
    
    @IBOutlet weak var orderNumberLabel: UILabel!
    @IBOutlet weak var orderTimeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func fill(with model: Order) {
           let dateFormatter = DateFormatter()
           dateFormatter.dateFormat = "dd.MM.YYYY, HH:mm"
        let stringDate = dateFormatter.string(from: model.orderCreated)
           orderTimeLabel.text = stringDate
           
           orderNumberLabel.text = "Order №\(model.orderId)"
       }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        selectionStyle = .none
    }
    
}
