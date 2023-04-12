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
        phoneNumberViewInit()
        prepareView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func phoneNumberViewInit() {
        let viewFromXib = Bundle.main.loadNibNamed("PhoneNumberView", owner: self, options: nil)![0] as! UIView
        viewFromXib.frame = self.bounds
        addSubview(viewFromXib)
    }

    func prepareView() {
        errorTextLabel.isHidden = true
        contentView.layer.cornerRadius = 5
    }
}
