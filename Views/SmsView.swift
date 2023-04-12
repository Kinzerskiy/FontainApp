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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        smsViewInit()
        prepareView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func smsViewInit() {
        let viewFromXib = Bundle.main.loadNibNamed("SmsView", owner: self, options: nil)![0] as! UIView
        viewFromXib.frame = self.bounds
        addSubview(viewFromXib)
        viewFromXib.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }

    func prepareView() {
        errorLabel.isHidden = true
        codeTextField.layer.cornerRadius = 5
    }
    
}
