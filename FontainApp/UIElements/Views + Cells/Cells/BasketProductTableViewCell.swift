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
    @IBOutlet weak var minusView: UIView!
    @IBOutlet weak var plusView: UIView!
    
    
    @IBOutlet weak var minusProductButton: UIButton!
    @IBOutlet weak var plusProductButton: UIButton!
    @IBOutlet weak var countLabel: UILabel!
    
    var addCompletion: (() -> Void)?
    var removeCompletion: (() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        prepareUI()
    }
    
    func fill () {
        
    }
    
    func prepareUI() {
        minusView.layer.cornerRadius = minusView.frame.size.width / 2
        minusView.clipsToBounds = true
        
        plusView.layer.cornerRadius = plusView.frame.size.width / 2
        plusView.clipsToBounds = true
        
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.blue.cgColor
    }
    
    @IBAction func lessPresed(_ sender: Any) {
        removeCompletion?()
    }
    
    @IBAction func morePressed(_ sender: Any) {
        addCompletion?()
    }
}
