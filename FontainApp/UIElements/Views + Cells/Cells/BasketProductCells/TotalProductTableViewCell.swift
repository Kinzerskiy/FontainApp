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
    @IBOutlet weak var firstView: UIView!
    
    @IBOutlet weak var countLabel: UILabel!
    
    @IBOutlet weak var plusView: UIView!
    @IBOutlet weak var minusView: UIView!
    
    @IBOutlet weak var plusButton: UIButton!
    @IBOutlet weak var minusButton: UIButton!
    
    
    var addCompletion: (() -> Void)?
    var removeCompletion: (() -> Void)?
    var removeAllCompletion: (() -> Void)?
    override func awakeFromNib() {
        super.awakeFromNib()
        prepareView()
        selectionStyle = .none
    }
    
    func fill(with model: BasketProduct) {
        productNameLabel.text = model.product.name
        productMeasureLabel.text = model.product.measure
        countLabel.text = String(model.count)
        
        productPriceLabel.text = "€" + String(model.product.price)
        
        guard let imageUrl = model.product.productImageUrl, let source = URL.init(string: imageUrl) else { return }
        productImage.kf.setImage(with: source)
        
        
    }
    
    func prepareView() {
        minusView.layer.cornerRadius = minusView.frame.size.width / 2
        minusView.layer.borderWidth = 1
        minusView.layer.borderColor = UIColor(named: "Primary")?.cgColor
        minusView.clipsToBounds = true
        
        plusView.layer.cornerRadius = plusView.frame.size.width / 2
        plusView.layer.borderWidth = 1
        plusView.layer.borderColor = UIColor(named: "Primary")?.cgColor
        plusView.clipsToBounds = true
        
        
        firstView.layer.borderWidth = 1
        firstView.layer.cornerRadius = 12
        firstView.layer.borderColor = UIColor(named: "Primary")?.cgColor
    }
    
    
    @IBAction func plusButtonAction(_ sender: Any) {
        addCompletion?()
    }
    
    @IBAction func minusButtonAction(_ sender: Any) {
        removeCompletion?()
    }
    
    @IBAction func removeProductAction(_ sender: Any) {
        removeAllCompletion?()
    }
    
    
}
