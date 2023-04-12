//
//  ResendCodeView.swift
//  FontainApp
//
//  Created by Mac Pro on 12.04.2023.
//

import UIKit

class ResendCodeView: UIView {

    @IBOutlet weak var codeTimer: UIButton!
    
    class ResendCodeView: UIView {

        @IBOutlet weak var resendCodeButton: UIButton!
        var countdownTimer: Timer?
        var countdownSeconds = 60
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            totalViewInit()
            prepareView()
        }
        
        required init?(coder: NSCoder) {
            super.init(coder: coder)
        }
        
        func totalViewInit() {
            let viewFromXib = Bundle.main.loadNibNamed("ResendCodeView", owner: self, options: nil)![0] as! UIView
            viewFromXib.frame = self.bounds
            addSubview(viewFromXib)
            viewFromXib.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        }

        func prepareView() {
            countdownSeconds = 60
            
            countdownTimer?.invalidate()
            countdownTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateCountdownLabel), userInfo: nil, repeats: true)
        }
        
        @objc func updateCountdownLabel() {
            countdownSeconds -= 1
            
            if countdownSeconds == 0 {
                countdownTimer?.invalidate()
                countdownTimer = nil
                
                resendCodeButton.setTitle("Resend code", for: .normal)
            }
        }
        @IBAction func resendCodeAction(_ sender: UIButton) {
            prepareView()
        }
    }

}
