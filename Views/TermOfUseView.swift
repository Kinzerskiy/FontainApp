//
//  TermOfUseView.swift
//  FontainApp
//
//  Created by Mac Pro on 12.04.2023.
//

import UIKit

class TermOfUseView: UIView {

    @IBOutlet weak var termOfUseLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        cardViewInit()
        prepareView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func cardViewInit() {
        let viewFromXib = Bundle.main.loadNibNamed("TermOfUseView", owner: self, options: nil)![0] as! UIView
        viewFromXib.frame = self.bounds
        addSubview(viewFromXib)
        viewFromXib.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
    
    func prepareView() {
        let attributedString = NSMutableAttributedString(string: "I have read and agree to the ")
        let url = URL(string: "https://")!
        _ = NSRange(location: attributedString.length, length: 11)
        attributedString.append(NSAttributedString(string: "Terms of use", attributes: [NSAttributedString.Key.link: url]))
        attributedString.append(NSAttributedString(string: " of Water Delivery"))
        termOfUseLabel.attributedText = attributedString
    }
}
