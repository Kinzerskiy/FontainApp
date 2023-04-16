//
//  PreviosOrderTableViewCell.swift
//  FontainApp
//
//  Created by Mac Pro on 12.04.2023.
//

import UIKit

class PreviosOrderTableViewCell: UITableViewCell {

    @IBOutlet weak var orderDate: UILabel!
    @IBOutlet weak var orderProductLabel: UILabel!
    @IBOutlet weak var orderTotalLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func fill() {
        
    }
    
    
    @IBAction func detailOrderButton(_ sender: Any) {
        
    }
    
}
