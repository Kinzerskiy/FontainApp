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
    @IBOutlet weak var borderView: UIView!
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
        contentView?.layer.borderWidth = 1
        borderView?.layer.borderWidth = 1
        contentView?.layer.borderColor = UIColor.systemGray.cgColor
        borderView?.layer.borderColor = UIColor.systemGray.cgColor
        
        phoneNumberTextField?.addTarget(self, action: #selector(textFieldEdidtingDidChange(_ :)), for: UIControl.Event.editingChanged)
    }
    
    @objc func textFieldEdidtingDidChange(_ textField: UITextField) {
        let attributedString = NSMutableAttributedString(string: textField.text!)
        attributedString.addAttribute(NSAttributedString.Key.kern, value: CGFloat(3.0), range: NSRange(location: 0, length: attributedString.length))
        textField.attributedText = attributedString
        
        if let text = textField.text, text.isEmpty == false {
               if !text.hasPrefix(" ") {
                   textField.text = " " + text
               }
           }
        checkPhoneNumber()
    }
    
    static func setup(in view: UIView) -> PhoneNumberView {
        let phoneNumberView = PhoneNumberView.loadFromNib()!
        phoneNumberView.frame = view.bounds
        view.addSubview(phoneNumberView)
        return phoneNumberView
        }
    
    func checkPhoneNumber() {
        let phoneNumber = phoneNumberTextField.text ?? ""
        let isValidPhoneNumber = phoneNumber.count == 10
        
        errorTextLabel.isHidden = isValidPhoneNumber
        
        if isValidPhoneNumber {
            contentView?.layer.borderColor = UIColor.systemGray.cgColor
            borderView?.layer.borderColor = UIColor.systemGray.cgColor
        } else {
            contentView.layer.borderColor = UIColor(named: "Error")?.cgColor
            borderView.layer.borderColor = UIColor(named: "Error")?.cgColor
        }
    }
    
    
    func setCountryCodeAndFlagImage(code: String, flag: UIImage) {
            phoneRegionLabel.text = code
            flagImageView.image = flag
        }
    
    func getPhoneNumber(completion: @escaping (String) -> Void) {
        let phoneNumber = (phoneRegionLabel.text ?? "") + (phoneNumberTextField.text ?? "")
        completion(phoneNumber)
       
    }
    
    
    @IBAction func selectCountryButtonAction(_ sender: Any) {
        phoneCompletion?()
    }
}
