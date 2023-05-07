//
//  ProductCollectionViewCell.swift
//  FontainApp
//
//  Created by Mac Pro on 12.04.2023.
//

import UIKit

class ProductCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var firstView: UIView!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var productMeasureLabel: UILabel!
    @IBOutlet weak var productCostLabel: UILabel!
    @IBOutlet weak var productImageLabel: UIImageView!
    
    @IBOutlet weak var buyView: UIView!
    @IBOutlet weak var buyButton: UIButton!
    
    var buyComplition: (() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        prepareUI()
    }
    
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        setupConstraints()
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//        setupConstraints()
//    }
    
//    private func setupConstraints() {
//        contentView.addSubview(firstView)
//        firstView.translatesAutoresizingMaskIntoConstraints = false
//
//        // Create constraints
//        NSLayoutConstraint.activate([
//            firstView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
//            firstView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
//            firstView.topAnchor.constraint(equalTo: contentView.topAnchor),
//            firstView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
//        ])
//    }
//
//
   override  func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        let newSize = CGSize(width: 170, height: 170)
        let updatedLayoutAttributes = layoutAttributes
        updatedLayoutAttributes.size = newSize
        return updatedLayoutAttributes
    }
    
    
    func fill(with model: Product) {
        
        guard let imageUrl = model.productImageUrl, let source = URL.init(string: imageUrl) else { return }
        
        productImageLabel.kf.setImage(with: source)
        productNameLabel.text = model.name
        productMeasureLabel.text = model.measure
        productCostLabel.text = "€" + String(model.price)
        productImageLabel.image = UIImage(named: model.productImageUrl ?? "")
    }
    
    func prepareUI() {
        
        firstView.layer.cornerRadius = 12
        
        buyButton.layer.cornerRadius = buyButton.frame.size.width / 2
        buyButton.clipsToBounds = true
        
        buyView.layer.cornerRadius = buyView.frame.size.width / 2
        buyView.clipsToBounds = true
    }
    
    @IBAction func buyButtonPressed(_ sender: Any) {
        buyComplition?()
    }
    
}
