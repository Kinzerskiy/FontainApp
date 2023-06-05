//
//  ProfileViewController.swift
//  FontainApp
//
//  Created by Mac Pro on 06.06.2023.
//

import UIKit

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var profilePhoto: UIImageView!
    @IBOutlet weak var logOutButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareUI()
    }
    
    func prepareUI() {
        tableView.register(.init(nibName: "ProfileTableViewCell", bundle: nil), forCellReuseIdentifier: "ProfileTableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
        
        logOutButton.layer.cornerRadius = logOutButton.frame.height / 2
        logOutButton.layer.borderColor = UIColor.init(named: "Error")?.cgColor
        logOutButton.layer.borderWidth = 1
    }
    
  
    
    
    @IBAction func editProfileAction(_ sender: Any) {
        
    }
    
    @IBAction func logOutAction(_ sender: Any) {
        
    }
    
}

extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    
}
