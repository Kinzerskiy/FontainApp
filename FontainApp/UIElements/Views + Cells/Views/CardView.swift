//
//  CodeView.swift
//  FontainApp
//
//  Created by Mac Pro on 12.04.2023.
//

import UIKit

class CardView: UIView {
    
    @IBOutlet weak var cardNameTextField: UITextField!
    @IBOutlet weak var cardNumberTextField: UITextField!
    @IBOutlet weak var expDateTextField: UITextField!
    @IBOutlet weak var cvvTextField: UITextField!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        prepareView()
    }

    static func setup(in view: UIView) -> CardView {
        let cardView = CardView.loadFromNib()!
        cardView.frame = view.bounds
        view.addSubview(cardView)
        return cardView
    }
    
    func prepareView() {
       
    }
    

}

