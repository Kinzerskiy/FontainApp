//
//  CardViewController.swift
//  FontainApp
//
//  Created by Mac Pro on 11.05.2023.
//

import UIKit

class CardViewController: UIViewController {
    
    @IBOutlet weak var payButton: UIButton!
    @IBOutlet weak var totalPriceLabel: UILabel!
    
    @IBOutlet weak var paymentView: UIView!
    
    let viewModel = CardViewModel()
    var cardView: CardView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        prepareUI()
    }
    
    
    
    func prepareUI() {
        
        cardView = CardView.setup(in: paymentView)
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification: )), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    
    @objc private func hideKeyboard() {
        self.view.endEditing(true)
    }
    
    @objc private func keyboardWillShow(notification: NSNotification) {
        self.view.frame.origin.y = view.frame.origin.y - 100
    }
    
    @objc private func keyboardWillHide() {
        self.view.frame.origin.y = 0
    }
}
