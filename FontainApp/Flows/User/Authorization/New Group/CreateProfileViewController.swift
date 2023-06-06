//
//  CreateProfileViewController.swift
//  FontainApp
//
//  Created by Mac Pro on 05.06.2023.
//


import UIKit
import FirebaseStorage
import FirebaseAuth
import Kingfisher

class CreateProfileViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addPhotoButton: UIButton!
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var profilePhoto: UIImageView!
    
    @IBOutlet weak var saveButton: UIButton!
    
    var dataSource: [NameOfLabels] = [.fullName, .phoneNumber, .country, .city, .street, .zipCode]
    var user: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareUI()
    }
    
    func prepareUI() {
        
        saveButton.unactiveStyle()
        addPhotoButton.titleLabel?.font = UIFont(name: "ABeeZee", size: 14)
        navigationController?.isNavigationBarHidden = true
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(.init(nibName: "CreateProfileTableViewCell", bundle: nil), forCellReuseIdentifier: "CreateProfileTableViewCell")
        
        addPhotoButton.backgroundColor = .gray
        addPhotoButton.layer.cornerRadius = addPhotoButton.frame.size.width / 2
        addPhotoButton.clipsToBounds = true
        
        profilePhoto.layer.cornerRadius = profilePhoto.frame.size.width / 2
        profilePhoto.contentMode = .scaleAspectFill
        profilePhoto.clipsToBounds = true
        profilePhoto.isHidden = true
        
       
    }
    
    @IBAction func addPhotoAction(_ sender: Any) {
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.delegate = self
        picker.allowsEditing = true
        present(picker, animated: true)
    }
    
    @IBAction func editPhotoAction(_ sender: Any) {
        
    }
    
    @IBAction func saveAction(_ sender: Any) {
        guard user != nil else { return }
        
        if let profileImage = profilePhoto.image {
          
            let fileManager = FileManager()
            guard let imageData = profileImage.pngData(), let currentUser = Auth.auth().currentUser else { return }
            
            fileManager.uploadPhoto(userId: currentUser.uid, imageData: imageData) { [weak self] urlString in
                guard let self = self, let user = self.user else { return }
                
                let newUser = User(uuid: Auth.auth().currentUser!.uid,
                                   phoneNumber: user.phoneNumber,
                                   fullName: user.fullName,
                                   city: user.city,
                                   country: user.country,
                                   street: user.street,
                                   zipCode: user.zipCode,
                                   imageUrl: urlString)
                
                let userManager = UserManager()
                userManager.saveUserFields(user: newUser) { [weak self] in
                    self?.user = newUser
                }
            }
        } else {
            return
        }
    }
}
    
    
extension CreateProfileViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CreateProfileTableViewCell", for: indexPath) as? CreateProfileTableViewCell else {
            return UITableViewCell()
        }
        
        let section = indexPath.section
        let model = dataSource[section]
        
        cell.fill(with: model) { [weak self] text in
            self?.updateUserField(for: model, with: text)
        }
        return cell
    }
    
    func updateUserField(for model: NameOfLabels, with text: String) {
        
        switch model {
        case .fullName:
            user?.fullName = text
        case .phoneNumber:
            user?.phoneNumber = text
        case .country:
            user?.country = text
        case .city:
            user?.city = text
        case .street:
            user?.street = text
        case .zipCode:
            user?.zipCode = text
        }
        guard let user = user else { return }
        if user.checkIsUserFilled() {
            saveButton.activeStyle()
        } else {
            saveButton.unactiveStyle()
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}
    
extension CreateProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        dismiss(animated: true, completion: nil)
        
        if let pickedImage = info[.editedImage] as? UIImage {
            profilePhoto.image = pickedImage
            addPhotoButton.isHidden = true
            profilePhoto.isHidden = false
        }
    }
}
