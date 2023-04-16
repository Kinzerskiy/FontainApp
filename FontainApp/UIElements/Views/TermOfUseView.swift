//
//  TermOfUseView.swift
//  FontainApp
//
//  Created by Mac Pro on 12.04.2023.
//

import UIKit

class TermOfUseView: UIView {

    @IBOutlet weak var termOfUseLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        prepareView()
    }
    
    static func setup(in view: UIView) -> TermOfUseView {
        
        let termOfUseView = TermOfUseView.loadFromNib()!
        
        termOfUseView.frame = view.bounds
        view.addSubview(termOfUseView)
        return termOfUseView
        }
    
    
    func prepareView() {
        let attributedString = NSMutableAttributedString(string: "I have read and agree to the ")
        let url = URL(string: "https://")!
        _ = NSRange(location: attributedString.length, length: 11)
        attributedString.append(NSAttributedString(string: "Terms of use", attributes: [NSAttributedString.Key.link: url]))
        attributedString.append(NSAttributedString(string: " of Water Delivery"))
        termOfUseLabel?.attributedText = attributedString
    }
    
}
