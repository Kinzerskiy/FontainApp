//
//  ItemAddedToCardView.swift
//  FontainApp
//
//  Created by Mac Pro on 12.04.2023.
//

import UIKit

class ItemAddedToCardView: UIView {

    
    @IBOutlet weak var addToCardView: UIView!
    @IBOutlet weak var viewButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        prepareView()
        registerNotifications()
           }

           deinit {
               NotificationCenter.default.removeObserver(self)
           }

           func registerNotifications() {
               NotificationCenter.default.addObserver(self, selector: #selector(hideView), name: NSNotification.Name(rawValue: "BuyButtonPressedNotification"), object: nil)
           }

    @objc func hideView() {
        self.alpha = 0.0
        self.isHidden = false
        
        UIView.animate(withDuration: 0.0, delay: 2.0, options: [.curveEaseInOut], animations: { [weak self] in
            self?.frame.origin.y -= 100
            self?.alpha = 1.0
        }) { [weak self] _ in
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                UIView.animate(withDuration: 0.0, delay: 0.0, options: [.curveEaseInOut], animations: { [weak self] in
                    self?.frame.origin.y += 100
                    self?.alpha = 0.0
                }) { [weak self] _ in
                    self?.isHidden = true
                    self?.frame.origin.y = 0
                }
            }
        }
    }
    
   
        
    
    private func hideViewWithAnimation() {
            UIView.animate(withDuration: 0.5, delay: 0.0, options: [.curveEaseOut], animations: { [weak self] in
                guard let superviewHeight = self?.superview?.bounds.height else { return }
                self?.frame.origin.y = superviewHeight
            }) { [weak self] _ in
                self?.isHidden = true
            }
        }
    
    static func setup(in view: UIView) -> ItemAddedToCardView {
        let itemAddedToCardView = ItemAddedToCardView.loadFromNib()!
        itemAddedToCardView.frame = view.bounds
        view.addSubview(itemAddedToCardView)
        return itemAddedToCardView
    }
    
    func prepareView() {
        addToCardView?.layer.cornerRadius = 12
    }
    
  
    
    @IBAction func viewBuyAction(_ sender: Any) {
      
    }
}
