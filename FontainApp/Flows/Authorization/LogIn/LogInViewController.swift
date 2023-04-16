//
//  LogInViewController.swift
//  FontainApp
//
//  Created by Mac Pro on 15.04.2023.
//

import UIKit

class LogInViewController: UIViewController {
    
    var viewModel = LogInViewModel()
    
    @IBOutlet weak var phoneNumberView: UIView!
    @IBOutlet weak var termOfUseView: TermOfUseView!
    @IBOutlet weak var sendSmsButton: UIButton!
    
    
    let phoneNumber = PhoneNumberView.loadFromNib()!
    
    let termOfUse = TermOfUseView.loadFromNib()!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        phoneNumber.frame = phoneNumberView.bounds
        phoneNumberView.addSubview(phoneNumber)
        
        termOfUse.frame = termOfUseView.bounds
        termOfUseView.addSubview(termOfUse)
    }
    
    
    @IBAction func loginDidTap(_ sender: Any) {
        viewModel.login(phoneNumber: "") {
            
        }
    }
}
