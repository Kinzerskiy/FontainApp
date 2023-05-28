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
    
    var isShowing = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        prepareView()
        
           }

    func show(){
        
        if isShowing { return }
        alpha = 0
        isHidden = false
        
        UIView.animate(withDuration: 0.2, animations: {
            self.isShowing = true
            self.alpha = 1
        }) { isFinished in
            if isFinished {
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
                    UIView.animate(withDuration: 0.2, animations: {
                        self.alpha = 0
                    }) { isFinished in
                        if isFinished {
                            self.isHidden = true
                            self.isShowing = false
                        }
                    }
                })
               
            }
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
