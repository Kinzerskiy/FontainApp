//
//  CodeViewController.swift
//  FontainApp
//
//  Created by Mac Pro on 26.04.2023.
//

import UIKit
import FirebaseAuth

class CodeViewController: UIViewController {
    
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var codeView: UIView!
    @IBOutlet weak var resendButton: UIButton!
    
    var smsView: SmsView?
    var viewModel: CodeViewModel?
    
    var phoneNumber: String?
    var currentVerificationID: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startTimer()
        prepareView()
        
        smsView?.codeTextField.delegate = self
    }
    
    func prepareView() {
        
        smsView = SmsView.setup(in: codeView)
        
        resendButton.isHidden = true
        
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(hideKeyboard)))
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification: )), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        nextButton.unactiveStyle()
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
    
    
    @IBAction func nextButtonAction(_ sender: Any) {
        guard let code = smsView?.codeTextField.text else { return }
        
        viewModel?.authUserWithCode(code: code, completion: {
            
            let userManager = UserManager()
            guard let currentUser = Auth.auth().currentUser else { return }
            
            userManager.checkIfUserExist(userId: currentUser.uid) { isExist in
                if isExist {
                    let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                    let viewController = mainStoryboard.instantiateViewController(withIdentifier: "MainTabBar") as! UITabBarController
                    let navigationController = UINavigationController(rootViewController: viewController)
                    
                    UIApplication.shared.windows.first?.rootViewController = navigationController
                    UIApplication.shared.windows.first?.makeKeyAndVisible()
                } else {
                    let user = User(uuid: currentUser.uid, phoneNumber: nil, fullName: nil, address: nil, imageUrl: nil)
                    userManager.saveUserFields(user: user) {
                        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                        let viewController = mainStoryboard.instantiateViewController(withIdentifier: "MainTabBar") as! UITabBarController
                        let navigationController = UINavigationController(rootViewController: viewController)
                        
                        UIApplication.shared.windows.first?.rootViewController = navigationController
                        UIApplication.shared.windows.first?.makeKeyAndVisible()
                    }
                }
            }
        })
    }
    
    
    func startTimer() {
        var countdown = 4
        _ = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            countdown -= 1
            self.timerLabel.text = "0:\(countdown)"
            if countdown == 0 {
                timer.invalidate()
                self.timerLabel.isHidden = true
                self.resendButton.isHidden = false
            }
        }
    }
    
    @IBAction func resendDidTap(_ sender: Any) {
        guard let phoneNumber = phoneNumber else { return }
            viewModel?.resendCode(to: phoneNumber) { error in
                if error != nil {
                   print("code not send")
                }
            }
        
        resendButton.isHidden = true
        timerLabel.isHidden = false
        startTimer()
    }
}

extension CodeViewController: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textView: UITextField) {
        if smsView?.codeTextField.text?.count == 6 {
            nextButton.activeStyle()
        } else {
            nextButton.unactiveStyle()
        }
    }
}
