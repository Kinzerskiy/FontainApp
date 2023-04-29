//
//  CodeViewController.swift
//  FontainApp
//
//  Created by Mac Pro on 26.04.2023.
//

import UIKit

class CodeViewController: UIViewController {
    
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var codeView: UIView!
    @IBOutlet weak var resendButton: UIButton!
    
    var smsView: SmsView?
    var viewModel: CodeViewModel?
    
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
            //perfornSegue to product list
        })
    }
    
    func startTimer() {
        var countdown = 4
        let timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            countdown -= 1
            self.timerLabel.text = "0:\(countdown)"
            if countdown == 0 {
                timer.invalidate()
                self.timerLabel.isHidden = true
                self.resendButton.isHidden = false
                // button resend should be shown
            }
        }
    }
    
    @IBAction func resendDidTap(_ sender: Any) {
       
        
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
