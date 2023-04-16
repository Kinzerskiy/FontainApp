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
    @IBOutlet weak var phoneNumberTextField: UITextField!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
//        errorTextLabel.isHidden = true
//        contentView.layer.cornerRadius = 5
    }
    
    static func setup(in view: UIView) -> PhoneNumberView {
        let phoneNumberView = PhoneNumberView.loadFromNib()!
        phoneNumberView.frame = view.bounds
        view.addSubview(phoneNumberView)
        return phoneNumberView
        }
    
    func getPhoneNumber() -> String {
        
        return phoneNumberTextField.text ?? ""
    }
}
