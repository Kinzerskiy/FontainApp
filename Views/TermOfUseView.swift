//
//  TermOfUseView.swift
//  FontainApp
//
//  Created by Mac Pro on 12.04.2023.
//

import UIKit

class TermOfUseView: UIView {

    @IBOutlet weak var termOfUseLabel: UILabel!
    
    func setup() -> NSMutableAttributedString {
        let attributedString = NSMutableAttributedString(string: "I have read and agree to the ")
        let url = URL(string: "https://")!
        let termsOfUseRange = NSRange(location: attributedString.length, length: 11)
        attributedString.append(NSAttributedString(string: "Terms of use", attributes: [NSAttributedString.Key.link: url]))
        attributedString.append(NSAttributedString(string: " of Water Delivery"))
        
        return attributedString
    }
    
//    let termOfUseView = TermOfUseView()
//    let attributedString = termOfUseView.setup()
//    termOfUseView.termOfUseLabel.attributedText = attributedString

}
