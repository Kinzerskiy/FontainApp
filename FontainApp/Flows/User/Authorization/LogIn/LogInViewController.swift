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
    @IBOutlet weak var termOfUseView: UIView!
    @IBOutlet weak var sendSmsButton: UIButton!
    @IBOutlet weak var picker: CountryPicker!
    
    var selectedCountryCode: String?
    var viewModel = LogInViewModel()
    var phoneNumber: PhoneNumberView?
    var termOfUse: TermOfUseView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.prepareView()
        
        phoneNumber?.phoneNumberTextField.delegate = self
    }
    
    func prepareView() {
        navigationItem.setHidesBackButton(true, animated: true)
        sendSmsButton.unactiveStyle()
        
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(hideKeyboard)))
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification: )), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        picker.isHidden = true
        
        let locale = Locale.current
        _ = (locale as NSLocale).object(forKey: NSLocale.Key.countryCode) as! String?
        picker.displayOnlyCountriesWithCodes = ["UA"] //display only
        picker.exeptCountriesWithCodes = ["RU"] //exept country
        let theme = CountryViewTheme(countryCodeTextColor: .black, countryNameTextColor: .black, rowBackgroundColor: .white, showFlagsBorder: true)
        picker.theme = theme
        picker.countryPickerDelegate = self
        picker.showPhoneNumbers = true
        picker.setCountry(phoneNumber?.phoneNumberTextField.text ?? "")
        
        phoneNumber = PhoneNumberView.setup(in: phoneNumberView)
        
        termOfUseView = TermOfUseView.setup(in: termOfUseView, privacyAcceptenceCompletion:
                                                { [weak self] isSelected in
            self?.viewModel.isPrivacyAccepted = isSelected
            self?.updateButtonState()
        })
       
        phoneNumber?.phoneCompletion = {
            self.picker.isHidden = false
            self.termOfUseView.isHidden = true
            self.sendSmsButton.isHidden = true
        }
    }

    
    @objc private func hideKeyboard() {
        self.view.endEditing(true)
    }
    
    @objc private func keyboardWillShow(notification: NSNotification) {
        self.view.frame.origin.y = view.frame.origin.y - 100
    }
    
    @objc private func keyboardWillHide() {
        self.view.frame.origin.y = 0
    }
    
    
    func countryPhoneCodePicker(_ picker: CountryPicker, didSelectCountryWithName name: String, countryCode: String, phoneCode: String, flag: UIImage) {
        DispatchQueue.main.async {
            self.phoneNumber?.setCountryCodeAndFlagImage(code: phoneCode, flag: flag)
            self.picker.isHidden = true
            self.termOfUseView.isHidden = false
            self.sendSmsButton.isHidden = false
        }
    }
    
    @IBAction func loginDidTap(_ sender: Any) {
        viewModel.login { verificationID in
            guard let verificationID = verificationID else { return }
            self.performSegue(withIdentifier: "validCode", sender: verificationID)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let codeViewController = segue.destination as? CodeViewController {
            codeViewController.viewModel = .init(verificationID: sender as! String)
            codeViewController.phoneNumber = viewModel.phoneNumber
        }
    }
    
    func updateButtonState() {
        if viewModel.isValidData() {
            sendSmsButton.activeStyle()
        } else {
            sendSmsButton.unactiveStyle()
        }
    }
}

extension LogInViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        phoneNumber?.getPhoneNumber { phoneNumber in
            self.viewModel.phoneNumber = phoneNumber
            self.updateButtonState()
        }
    }
}
