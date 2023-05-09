//
//  PreviousOrderDetailTableViewCell.swift
//  FontainApp
//
//  Created by Mac Pro on 12.04.2023.
//

import UIKit

class PreviousOrderDetailTableViewCell: UITableViewCell {

    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productMeasure: UILabel!
    @IBOutlet weak var productCost: UILabel!
    
    @IBOutlet weak var minusButton: UIButton!
    @IBOutlet weak var plusButton: UIButton!
    @IBOutlet weak var countLabel: UIStackView!
    
    @IBOutlet weak var minusView: UIView!
    @IBOutlet weak var plusView: UIView!
    
    var addCompletion: (() -> Void)?
    var removeCompletion: (() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        prepareUI()
    }
    
    func fill () {
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func prepareUI() {
        minusView.layer.cornerRadius = minusView.frame.size.width / 2
        minusView.clipsToBounds = true
        
        plusView.layer.cornerRadius = plusView.frame.size.width / 2
        plusView.clipsToBounds = true
    }
    
    @IBAction func lessPresed(_ sender: Any) {
        removeCompletion?()
    }
    
    @IBAction func morePressed(_ sender: Any) {
        addCompletion?()
    }
}
