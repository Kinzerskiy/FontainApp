//
//  CreateProfileTableViewCell.swift
//  FontainApp
//
//  Created by Mac Pro on 05.06.2023.
//

import UIKit

enum  NameOfLabels: String  {
    case fullName = "Full name"
    case country = "Country"
    case city = "City"
    case street = "Street, house number"
    case zipCode = "Zip - Code"
    }

class CreateProfileTableViewCell: UITableViewCell {

    @IBOutlet weak var fieldNameLabel: UILabel!
    @IBOutlet weak var infoTextField: UITextField!
    
    var infoCompletion: ((String) -> Void)?
    var isFilled: Bool = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        selectionStyle = .none
    }
    
    func fill(with model: NameOfLabels, infoCompletion: @escaping (String) -> Void) {
        fieldNameLabel.text = model.rawValue
        fieldNameLabel.font = UIFont(name: "ABeeZee", size: 14)
        
        self.infoCompletion = infoCompletion
        
        infoTextField.addTarget(self, action: #selector(infoTextFieldDidChange), for: .editingChanged)
    }
    
    
    @objc func infoTextFieldDidChange(_ textField: UITextField) {
           if let text = textField.text {
               self.isFilled = !text.isEmpty
               infoCompletion?(text)
           }
       }
}
