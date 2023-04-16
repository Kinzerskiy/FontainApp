//
//  StoreInfoView.swift
//  FontainApp
//
//  Created by Mac Pro on 12.04.2023.
//

import UIKit

class StoreInfoView: UIView {

    @IBOutlet weak var storeInfoImage: UIImageView!

    override init(frame: CGRect) {
        super.init(frame: frame)
        totalViewInit()
        prepareView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func totalViewInit() {
        let viewFromXib = Bundle.main.loadNibNamed("StoreInfoView", owner: self, options: nil)![0] as! UIView
        viewFromXib.frame = self.bounds
        addSubview(viewFromXib)
        viewFromXib.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }

    func prepareView() {
       
    }
}
