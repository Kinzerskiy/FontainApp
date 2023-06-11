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
    
    func checkCode() {
        let codeText = codeTextField.text ?? ""
        let isValidCode = codeText.count == 6
        
        errorLabel.isHidden = isValidCode
        
        if isValidCode {
            codeTextField.layer.borderColor = UIColor.systemGray.cgColor
            codeTextField.layer.borderWidth = 0
           } else {
               codeTextField.layer.borderColor = UIColor(named: "Error")?.cgColor
               codeTextField.layer.borderWidth = 1.0
           }
       }
    
    @objc func textFieldEdidtingDidChange(_ textField :UITextField) {
        let attributedString = NSMutableAttributedString(string: textField.text!)
        attributedString.addAttribute(NSAttributedString.Key.kern, value: CGFloat(20.0), range: NSRange(location: 0, length: attributedString.length))
        textField.attributedText = attributedString
        
        checkCode()
    }
}
