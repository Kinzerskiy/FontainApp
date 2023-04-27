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
    
    var smsView: SmsView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareView()
    }
    
    
    func prepareView() {
        nextButton.unactiveStyle()
        smsView = SmsView.setup(in: codeView)
    }
    
    @IBAction func nextButtonAction(_ sender: Any) {
        
    }
}
