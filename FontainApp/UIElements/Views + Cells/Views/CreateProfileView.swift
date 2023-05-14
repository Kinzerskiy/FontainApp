//
//  CreateProfileView.swift
//  FontainApp
//
//  Created by Mac Pro on 11.05.2023.
//

import UIKit

class CreateProfileView: UIView {

    @IBOutlet weak var addPhotoButton: UIButton!
    
    @IBOutlet weak var fullNameTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var countryTextField: UITextField!
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var streetHouseNumberTextField: UITextField!
    @IBOutlet weak var zipCodeTextField: UITextField!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        prepareView()
    }

    static func setup(in view: UIView) -> CreateProfileView {
        let createProfileView = CreateProfileView.loadFromNib()!
        createProfileView.frame = view.bounds
        view.addSubview(createProfileView)
        return createProfileView
    }
    
    func prepareView() {
        addPhotoButton?.layer.cornerRadius = addPhotoButton.frame.size.width / 2
    }
    
    
    
    
    @IBAction func editProfileButtonAction(_ sender: Any) {
    }
    
}
