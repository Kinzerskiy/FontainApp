//
//  DeliveryAdressTableViewCell.swift
//  FontainApp
//
//  Created by Mac Pro on 08.05.2023.
//

import UIKit

class DeliveryAdressTableViewCell: UITableViewCell {

    @IBOutlet weak var addressTextField: UITextField!
    
    var deliveryAddressCompletion: ((String) -> Void)?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
         selectionStyle = .none
    }
    
    
    func fill(with model: TextFieldCellViewModel) {
        addressTextField.text = model.address
        deliveryAddressCompletion = model.completion
    }
    
}
