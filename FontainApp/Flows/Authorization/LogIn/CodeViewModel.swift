//
//  CodeViewModel.swift
//  FontainApp
//
//  Created by Mac Pro on 26.04.2023.
//

import Foundation
import FirebaseAuth

class CodeViewModel {
    
    var verificationID: String!
    
    func authUserWithCode(code: String, completion: @escaping () -> ()) {
        let credential = PhoneAuthProvider.provider().credential(
            withVerificationID: verificationID,
            verificationCode: code)
        
        Auth.auth().signIn(with: credential) { [weak self] _, error in
            if error != nil {
                print(error?.localizedDescription)
            } else {
                let userManager = UserManager()
                guard let currentUser = Auth.auth().currentUser else { return }
                
                userManager.checkIfUserExist(userId: currentUser.uid) { isExist in
                    if isExist {
                        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                        let viewController = mainStoryboard.instantiateViewController(withIdentifier: "ProductViewController") as! ProductViewController
                        let navigationController = UINavigationController(rootViewController: viewController)
                        
                        UIApplication.shared.windows.first?.rootViewController = navigationController
                        UIApplication.shared.windows.first?.makeKeyAndVisible()
                    } else {
                        let user = User(uuid: currentUser.uid, phoneNumber: nil, fullName: nil, address: nil, imageUrl: nil)
                        userManager.saveUserFields(user: user) { [weak self] in
//                            self?.performSegue(withIdentifier: "", sender: nil)
                        }
                    }
                }
                
            }
        }
        
    }
}


