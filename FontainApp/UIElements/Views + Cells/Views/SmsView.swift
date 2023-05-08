//
//  SmsView.swift
//  FontainApp
//
//  Created by Mac Pro on 12.04.2023.
//

import UIKit

class SmsView: UIView {
    
    @IBOutlet weak var codeTextField: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        errorLabel?.isHidden = true
        codeTextField?.layer.cornerRadius = 5
        
        codeTextField?.textContentType = .oneTimeCode
        codeTextField?.keyboardType = .numberPad
        
        codeTextField?.addTarget(self, action: #selector(textFieldEdidtingDidChange(_ :)), for: UIControl.Event.editingChanged)
        
        
    }
    
    static func setup(in view: UIView) -> SmsView {
        let smsView = SmsView.loadFromNib()!
        smsView.frame = view.bounds
        view.addSubview(smsView)
        return smsView
    }
    
    @objc func textFieldEdidtingDidChange(_ textField :UITextField) {
        let attributedString = NSMutableAttributedString(string: textField.text!)
        attributedString.addAttribute(NSAttributedString.Key.kern, value: CGFloat(20.0), range: NSRange(location: 0, length: attributedString.length))
        textField.attributedText = attributedString
    }
}
