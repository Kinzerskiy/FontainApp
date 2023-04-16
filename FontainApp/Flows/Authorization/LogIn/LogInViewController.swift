//
//  LogInViewController.swift
//  FontainApp
//
//  Created by Mac Pro on 15.04.2023.
//

import UIKit
import CountryPicker

class LogInViewController: UIViewController, CountryPickerDelegate {
    
    @IBOutlet weak var phoneNumberView: UIView!
    @IBOutlet weak var termOfUseView: TermOfUseView!
    @IBOutlet weak var sendSmsButton: UIButton!
    @IBOutlet weak var picker: CountryPicker!
    
    var viewModel = LogInViewModel()
    let phoneNumber = PhoneNumberView.loadFromNib()!
    let termOfUse = TermOfUseView.loadFromNib()!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.setHidesBackButton(true, animated: true)
        prepareView()
        
    }
    
    func prepareView() {
        
        phoneNumber.phoneRegionLabel =
        phoneNumber.flagImageView =
        
        
        let locale = Locale.current
        let code = (locale as NSLocale).object(forKey: NSLocale.Key.countryCode) as! String?
                //init Picker
        picker.displayOnlyCountriesWithCodes = ["UA", "SE", "NO", "DE"] //display only
        picker.exeptCountriesWithCodes = ["RU"] //exept country
        let theme = CountryViewTheme(countryCodeTextColor: .white, countryNameTextColor: .white, rowBackgroundColor: .black, showFlagsBorder: false)        //optional for UIPickerView theme changes
        picker.theme = theme //optional for UIPickerView theme changes
        picker.countryPickerDelegate = self
        picker.showPhoneNumbers = true
        picker.setCountry(code!)
        
        phoneNumber.frame = phoneNumberView.bounds
        phoneNumberView.addSubview(phoneNumber)
        
        termOfUse.frame = termOfUseView.bounds
        termOfUseView.addSubview(termOfUse)
        
        sendSmsButton.layer.cornerRadius = 30
    }
    
    func countryPhoneCodePicker(_ picker: CountryPicker.CountryPicker, didSelectCountryWithName name: String, countryCode: String, phoneCode: String, flag: UIImage) {
        code.text = phoneCode
    }
    
    @IBAction func loginDidTap(_ sender: Any) {
        viewModel.login(phoneNumber: "") {
            
        }
    }
}
