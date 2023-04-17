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
    
    var newImageView: UIImageView!
        
        var imageViewTappedCompletion: (() -> Void)?
            
        override func awakeFromNib() {
            super.awakeFromNib()
            prepareView()
            accessTapped()
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
            
    func accessTapped() {
        
        termOfUseAcceptImage?.image = UIImage(named: "Property 1=empty")
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageViewTapped))
        termOfUseAcceptImage?.addGestureRecognizer(tapGestureRecognizer)
        
        if let acceptImage = termOfUseAcceptImage {
            newImageView = UIImageView(frame: acceptImage.frame)
            newImageView.image = UIImage(named: "Property 1=filled")
            newImageView.isHidden = true
            addSubview(newImageView)
        }
    }
        @objc func imageViewTapped() {
            termOfUseAcceptImage.isHidden = true
            newImageView.isHidden = false
            imageViewTappedCompletion?()
        }
    }
