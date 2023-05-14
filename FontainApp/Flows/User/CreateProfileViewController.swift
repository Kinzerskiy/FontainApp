//
//  CreateProfileViewController.swift
//  FontainApp
//
//  Created by Mac Pro on 29.04.2023.
//

import UIKit

class CreateProfileViewController: UIViewController {

    @IBOutlet weak var createProfileView: UIView!
    @IBOutlet weak var createProfileButton: UIButton!
    
    var createProfile: CreateProfileView?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
    }
    
    func prepareUI() {
        createProfile = CreateProfileView.setup(in: createProfileView)
        createProfileButton.unactiveStyle()
    }
    
    
    @IBAction func saveFieldsAction(_ sender: Any) {
        
    }
    
}


//let content = UNMutableNotificationContent()
//content.title = "«Water Delivery» Would Like to Send You Notifications"
//content.body = "Notifications may include alerts, sounds and icon badges. They can be configured in Settings."
//let request = UNNotificationRequest(identifier: "notificationPermission", content: content, trigger: nil)
//let center = UNUserNotificationCenter.current()
//center.requestAuthorization(options: [.alert, .sound, .badge]) { (granted, error) in
//    if let error = error {
//        print("Error requesting authorization: \(error.localizedDescription)")
//    } else {
//        if granted {
//            center.add(request) { (error) in
//                if let error = error {
//                    print("Error adding notification request: \(error.localizedDescription)")
//                } else {
//                    print("Notification request added successfully")
//                }
//            }
//        } else {
//            let alert = UIAlertController(title: "Notifications Disabled", message: "You can enable notifications in Settings.", preferredStyle: .alert)
//            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
//            self.present(alert, animated: true, completion: nil)
//        }
//    }
//}
