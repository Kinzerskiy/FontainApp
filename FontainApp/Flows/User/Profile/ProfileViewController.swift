//
//  ProfileViewController.swift
//  FontainApp
//
//  Created by Mac Pro on 06.06.2023.
//

import UIKit
import FirebaseStorage
import FirebaseAuth
import Kingfisher

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var profilePhoto: UIImageView!
    @IBOutlet weak var logOutButton: UIButton!
    @IBOutlet weak var editProfileButton: UIButton!
    
    let userManager = UserManager()
    var user: User?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadUserData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareUI()
    }
    
    func updateUI(with user: User) {
        guard let imageUrl = user.imageUrl, let source = URL.init(string: imageUrl) else { return }
        profilePhoto.kf.setImage(with: source)
    }
    
    func loadUserData() {
            guard let currentUser = Auth.auth().currentUser else { return }
        
            userManager.getUserInfo(userId: currentUser.uid) { [weak self] user in
                guard let user = user else { return }
                self?.user = user
                self?.updateUI(with: user)
                self?.tableView.reloadData()
            }
        }
    
    func prepareUI() {
        tableView.register(.init(nibName: "ProfileTableViewCell", bundle: nil), forCellReuseIdentifier: "ProfileTableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
        
        logOutButton.layer.cornerRadius = 12
        logOutButton.layer.borderColor = UIColor.init(named: "Error")?.cgColor
        logOutButton.layer.borderWidth = 1
        tableView.separatorStyle = .none
        
        profilePhoto.layer.cornerRadius = profilePhoto.frame.size.width / 2
        profilePhoto.contentMode = .scaleAspectFill
        profilePhoto.clipsToBounds = true
    }
    
    @IBAction func editProfileAction(_ sender: Any) {
        let user = User(uuid: user?.uuid,
                        phoneNumber: nil,
                        fullName: nil,
                        city: nil,
                        country: nil,
                        street: nil,
                        zipCode: nil,
                        imageUrl: nil)
        userManager.saveUserFields(user: user) { [weak self] in
            
            let vc = self?.storyboard?.instantiateViewController(withIdentifier: "CreateProfileViewController") as! CreateProfileViewController
            
            vc.user = user
            self?.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @IBAction func logOutAction(_ sender: Any) {
        do {
            try Auth.auth().signOut()
            let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let viewController = mainStoryboard.instantiateViewController(withIdentifier: "WelcomeViewController") as! WelcomeViewController
            let navigationController = UINavigationController(rootViewController: viewController)

            UIApplication.shared.windows.first?.rootViewController = navigationController
            UIApplication.shared.windows.first?.makeKeyAndVisible()
            
           } catch let error as NSError {
               print("Error signing out: \(error.localizedDescription)")
           }
       }
    
}

extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    
        func numberOfSections(in tableView: UITableView) -> Int {
            return 1
        }
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return 6
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileTableViewCell", for: indexPath) as! ProfileTableViewCell
            
            switch indexPath.row {
            case 0:
                cell.infoLabel.text = "Full Name"
                cell.profileInfoLabel.text = user?.fullName
            case 1:
                cell.infoLabel.text = "Phone Number"
                cell.profileInfoLabel.text = user?.phoneNumber
            case 2:
                cell.infoLabel.text = "City"
                cell.profileInfoLabel.text = user?.city
            case 3:
                cell.infoLabel.text = "Country"
                cell.profileInfoLabel.text = user?.country
            case 4:
                cell.infoLabel.text = "Street"
                cell.profileInfoLabel.text = user?.street
            case 5:
                cell.infoLabel.text = "Zip Code"
                cell.profileInfoLabel.text = user?.zipCode
            default:
                break
            }
            return cell
        }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}
