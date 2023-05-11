//
//  DeliveryInfoTableViewCell.swift
//  FontainApp
//
//  Created by Mac Pro on 08.05.2023.
//

import UIKit

class DeliveryInfoTableViewCell: UITableViewCell {

    @IBOutlet weak var callSwitch: UISwitch!
    @IBOutlet weak var contactlessSwitch: UISwitch!
    
    var contactlessSwitchCompletion: ((Bool) -> Void)?
    var callSwitchCompletion: ((Bool) -> Void)?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }
    
    func fill(with model: SwitcherCellViewModel) {
        callSwitch.isOn = model.callIsOn
        contactlessSwitch.isOn = model.contactlessIsOn
        
        contactlessSwitch.addTarget(self, action: #selector(contactlessSwitchValueChanged(_:)), for: .valueChanged)
        callSwitch.addTarget(self, action: #selector(callSwitchValueChanged(_:)), for: .valueChanged)

        contactlessSwitchCompletion = model.contactlessSwitchCompletion
        callSwitchCompletion = model.callSwitchCompletion
    }

    @objc func contactlessSwitchValueChanged(_ sender: UISwitch) {
        contactlessSwitchCompletion?(sender.isOn)
    }

    @objc func callSwitchValueChanged(_ sender: UISwitch) {
        callSwitchCompletion?(sender.isOn)
    }
}
