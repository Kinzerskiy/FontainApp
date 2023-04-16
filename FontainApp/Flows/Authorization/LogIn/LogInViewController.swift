//
//  LogInViewController.swift
//  FontainApp
//
//  Created by Mac Pro on 15.04.2023.
//

import UIKit
import CountryPicker

class LogInViewController: UIViewController, CountryPickerDelegate, UITextFieldDelegate {
    
    @IBOutlet weak var phoneNumberView: UIView!
    @IBOutlet weak var termOfUseView: TermOfUseView!
    @IBOutlet weak var sendSmsButton: UIButton!
    @IBOutlet weak var picker: CountryPicker!
    
    var selectedCountryCode: String?
    
    var viewModel = LogInViewModel()
    var phoneNumber = PhoneNumberView.loadFromNib()!
    let termOfUse = TermOfUseView.loadFromNib()!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        phoneNumber.phoneNumberTextField.delegate = self
        prepareView()
        
    }
    
    func prepareView() {
        navigationItem.setHidesBackButton(true, animated: true)
        picker.isHidden = true
        
        let locale = Locale.current
        let code = (locale as NSLocale).object(forKey: NSLocale.Key.countryCode) as! String?
        picker.displayOnlyCountriesWithCodes = ["UA", "SE", "NO", "DE"] //display only
        picker.exeptCountriesWithCodes = ["RU"] //exept country
        let theme = CountryViewTheme(countryCodeTextColor: .black, countryNameTextColor: .black, rowBackgroundColor: .white, showFlagsBorder: false)
        picker.theme = theme
        picker.countryPickerDelegate = self
        picker.showPhoneNumbers = true
        picker.setCountry(phoneNumber.phoneNumberTextField.text ?? "")
//
        
        phoneNumber.frame = phoneNumberView.bounds
        phoneNumberView.addSubview(phoneNumber)
        
        termOfUse.frame = termOfUseView.bounds
        termOfUseView.addSubview(termOfUse)
        
        sendSmsButton.layer.cornerRadius = 30
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == phoneNumber.phoneNumberTextField {
            picker.isHidden = false
            termOfUse.isHidden = true
            sendSmsButton.isHidden = true
            return false
           }
           return true
       }
    
    func countryPhoneCodePicker(_ picker: CountryPicker, didSelectCountryWithName name: String, countryCode: String, phoneCode: String, flag: UIImage) {
    
        phoneNumber.setCountryCodeAndFlagImage(code: phoneCode, flag: flag)
        picker.isHidden = true
        termOfUse.isHidden = false
        sendSmsButton.isHidden = false
    }
    
    @IBAction func loginDidTap(_ sender: Any) {
        viewModel.login(phoneNumber: "") {
            
            
            
        }
    }
}
