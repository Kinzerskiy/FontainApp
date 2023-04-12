//
//  SmsTableViewCell.swift
//  FontainApp
//
//  Created by Mac Pro on 08.04.2023.
//

import UIKit

class SmsTableViewCell: UITableViewCell {

    @IBOutlet weak var codeTextField: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
