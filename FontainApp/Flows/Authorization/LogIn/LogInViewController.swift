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
    }
    
    func prepareView() {
        navigationItem.setHidesBackButton(true, animated: true)
        
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(hideKeyboard)))
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification: )), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        picker.isHidden = true
        
        let locale = Locale.current
        _ = (locale as NSLocale).object(forKey: NSLocale.Key.countryCode) as! String?
        picker.displayOnlyCountriesWithCodes = ["UA", "SE", "NO", "DE"] //display only
        picker.exeptCountriesWithCodes = ["RU"] //exept country
        let theme = CountryViewTheme(countryCodeTextColor: .black, countryNameTextColor: .black, rowBackgroundColor: .white, showFlagsBorder: false)
        picker.theme = theme
        picker.countryPickerDelegate = self
        picker.showPhoneNumbers = true
        picker.setCountry(phoneNumber?.phoneNumberTextField.text ?? "")
        
        phoneNumber = PhoneNumberView.setup(in: phoneNumberView)
        termOfUseView = TermOfUseView.setup(in: termOfUseView)
        
        phoneNumber?.phoneCompletion = {
            self.picker.isHidden = false
            self.termOfUse?.isHidden = true
            self.sendSmsButton.isHidden = true
        }
        
        sendSmsButton.activeStyle()
    }
    
    
    @objc private func hideKeyboard() {
        self.view.endEditing(true)
    }
    
    @objc private func keyboardWillShow(notification: NSNotification) {
//        if let keyboardFrame: CGRect = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? CGRect {
//            let keyboardHeight = keyboardFrame.height
//            let bottonSpace = self.view.frame.height - (sendSmsButton.frame.origin.y + sendSmsButton.frame.height)
            self.view.frame.origin.y = view.frame.origin.y - 100
    }
    
    @objc private func keyboardWillHide() {
        self.view.frame.origin.y = 0
    }
    
    
    func countryPhoneCodePicker(_ picker: CountryPicker, didSelectCountryWithName name: String, countryCode: String, phoneCode: String, flag: UIImage) {
        DispatchQueue.main.async {
            self.phoneNumber?.setCountryCodeAndFlagImage(code: phoneCode, flag: flag)
            self.picker.isHidden = true
            self.termOfUse?.isHidden = false
            self.sendSmsButton.isHidden = false
        }
    }
    
    @IBAction func loginDidTap(_ sender: Any) {
        let phoneNumber = (selectedCountryCode ?? "+380") + (phoneNumber?.getPhoneNumber() ?? "")
        viewModel.login(phoneNumber: phoneNumber) {
        }
    }
}


//            let content = UNMutableNotificationContent()
//            content.title = "«Water Delivery» Would Like to Send You Notifications"
//            content.body = "Notifications may include alerts, sounds and icon badges. They can be configured in Settings."
//            let request = UNNotificationRequest(identifier: "notificationPermission", content: content, trigger: nil)
//            let center = UNUserNotificationCenter.current()
//            center.requestAuthorization(options: [.alert, .sound, .badge]) { (granted, error) in
//                if let error = error {
//                    print("Error requesting authorization: \(error.localizedDescription)")
//                } else {
//                    if granted {
//                        center.add(request) { (error) in
//                            if let error = error {
//                                print("Error adding notification request: \(error.localizedDescription)")
//                            } else {
//                                print("Notification request added successfully")
//                            }
//                        }
//                    } else {
//                        let alert = UIAlertController(title: "Notifications Disabled", message: "You can enable notifications in Settings.", preferredStyle: .alert)
//                        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
//                        self.present(alert, animated: true, completion: nil)
//                    }
//                }
//            }
