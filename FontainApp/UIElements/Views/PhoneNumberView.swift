//
//  PhoneNumberView.swift
//  FontainApp
//
//  Created by Mac Pro on 12.04.2023.
//

import UIKit
import FlagPhoneNumber

class PhoneNumberView: UIView {
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var contentView2: UIView!
    @IBOutlet weak var flagImageView: UIImageView!
    @IBOutlet weak var phoneRegionLabel: UILabel!
    @IBOutlet weak var selectPhoneRegionButton: UIButton!
    @IBOutlet weak var errorTextLabel: UILabel!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    
    var phoneCompletion: (() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        errorTextLabel?.isHidden = true
        contentView?.layer.cornerRadius = 5
        contentView2?.layer.cornerRadius = 5
    }
    
    static func setup(in view: UIView) -> PhoneNumberView {
        let phoneNumberView = PhoneNumberView.loadFromNib()!
        phoneNumberView.frame = view.bounds
        view.addSubview(phoneNumberView)
        return phoneNumberView
        }
    
    func setCountryCodeAndFlagImage(code: String, flag: UIImage) {
            phoneRegionLabel.text = code
            flagImageView.image = flag
        }
    
    func getPhoneNumber() -> String {
        return phoneNumberTextField.text ?? ""
    }
    
    @IBAction func selectCountryButtonAction(_ sender: Any) {
        phoneCompletion?()
    }
}
