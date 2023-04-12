//
//  PhoneNumberView.swift
//  FontainApp
//
//  Created by Mac Pro on 12.04.2023.
//

import UIKit

class PhoneNumberView: UIView {
    
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var flagImageView: UIImageView!
    @IBOutlet weak var phoneRegionLabel: UILabel!
    @IBOutlet weak var selectPhoneRegionButton: UIButton!
    @IBOutlet weak var errorTextLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func phoneInit() {
        Bundle.main.loadNibNamed("PhoneNumberView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }

    func prepareView() {
        errorTextLabel.isHidden = true
//        contentView.backgroundColor = UIColor.init(named: "Error")
        contentView.layer.cornerRadius = 12
    }
}
