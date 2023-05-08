//
//  CodeView.swift
//  FontainApp
//
//  Created by Mac Pro on 12.04.2023.
//

import UIKit

class CodeView: UIView {

    @IBOutlet weak var expDateTextField: UITextField!
    @IBOutlet weak var cvvTextField: UITextField!
    @IBOutlet weak var expFieldErrorLabel: UILabel!
    @IBOutlet weak var cvvFieldErrorLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        cardViewInit()
        prepareView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func cardViewInit() {
        let viewFromXib = Bundle.main.loadNibNamed("CodeView", owner: self, options: nil)![0] as! UIView
        viewFromXib.frame = self.bounds
        addSubview(viewFromXib)
        viewFromXib.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }

    func prepareView() {
       
    }
    

}

