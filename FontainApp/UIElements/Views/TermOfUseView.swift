//
//  TermOfUseView.swift
//  FontainApp
//
//  Created by Mac Pro on 12.04.2023.
//

import UIKit

class TermOfUseView: UIView {
    
    @IBOutlet weak var termOfUseLabel: UILabel!
    @IBOutlet weak var termOfUseAcceptImage: UIImageView!
    
    var isSelected: Bool = false
    var privacyAcceptenceCompletion: ((Bool) -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        prepareView()
    }
    
    static func setup(in view: UIView, privacyAcceptenceCompletion: @escaping ((Bool) -> Void)) -> TermOfUseView {
        let termOfUseView = TermOfUseView.loadFromNib()!
        termOfUseView.privacyAcceptenceCompletion = privacyAcceptenceCompletion
        termOfUseView.frame = view.bounds
        view.addSubview(termOfUseView)
        return termOfUseView
    }
    
    func prepareView() {
        let attributedString = NSMutableAttributedString(string: "I have read and agree to the ")
        
        attributedString.append(NSAttributedString(string: "Terms of use", attributes: [.foregroundColor: UIColor(named: "Primary") ?? .white]))
        
        attributedString.append(NSAttributedString(string: " of Fontaine App"))
        termOfUseLabel?.attributedText = attributedString
        
        let textTapped = UITapGestureRecognizer(target: self, action: #selector(openUrl))
        termOfUseLabel.isUserInteractionEnabled = true
        termOfUseLabel.addGestureRecognizer(textTapped)
        
        let imageTapped = UITapGestureRecognizer(target: self, action: #selector(check))
        termOfUseAcceptImage.isUserInteractionEnabled = true
        termOfUseAcceptImage.addGestureRecognizer(imageTapped)
    }
    
    @objc func openUrl() {
        if let url = URL(string: "https://www.hackingwithswift.com") {
            UIApplication.shared.open(url)
        }
    }
    
    @objc func check() {
        isSelected.toggle()
        termOfUseAcceptImage.image = isSelected ? UIImage(named: "Property 1=filled") : UIImage(named: "Property 1=empty")
        privacyAcceptenceCompletion?(self.isSelected)
    }
}
