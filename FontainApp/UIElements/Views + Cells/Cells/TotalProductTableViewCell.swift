//
//  TotalProductTableViewCell.swift
//  FontainApp
//
//  Created by Mac Pro on 08.05.2023.
//

import UIKit

class TotalProductTableViewCell: UITableViewCell {
    
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var productMeasureLabel: UILabel!
    @IBOutlet weak var productPriceLabel: UILabel!
    
    @IBOutlet weak var plusView: UIView!
    @IBOutlet weak var minusView: UIView!
    
    @IBOutlet weak var plusButton: UIButton!
    @IBOutlet weak var minusButton: UIButton!
    
    var addCompletion: (() -> Void)?
    var removeCompletion: (() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        prepareView()
    }
    
    func fill(with model: BasketProduct) {
        productImage.image = UIImage(named: model.product.productImageUrl ?? "")
        productNameLabel.text = model.product.name
        productMeasureLabel.text = model.product.measure
        productPriceLabel.text = String(model.count)
    }
    
    func prepareView() {
        minusView.layer.cornerRadius = minusView.frame.size.width / 2
        minusView.layer.borderWidth = 1
        minusView.clipsToBounds = true
        
        plusView.layer.cornerRadius = plusView.frame.size.width / 2
        plusView.layer.borderWidth = 1
        plusView.clipsToBounds = true
        
        
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor(named: "Primary")?.cgColor
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    
    @IBAction func plusButtonAction(_ sender: Any) {
        addCompletion?()
    }
    
    @IBAction func minusButtonAction(_ sender: Any) {
        removeCompletion?()
    }
    
}
