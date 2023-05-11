//
//  LogInViewModel.swift
//  FontainApp
//
//  Created by Mac Pro on 15.04.2023.
//

import Foundation
import FirebaseAuth


class LogInViewModel {
    
    var phoneNumber: String = ""
    var isPrivacyAccepted: Bool = false
    
    func isValidData() -> Bool {
        return phoneNumber.count <= 11 && isPrivacyAccepted
        }
    
    func login(completion: @escaping (String?) -> ()) {
        
        PhoneAuthProvider.provider().verifyPhoneNumber(phoneNumber, uiDelegate: nil) { (verificationID, error) in
            if let verificationID = verificationID {
//                UserDefaults.standard.set(verificationID, forKey: "authVerificationID")
                completion(verificationID)
            } else if let error = error {
                print(error.localizedDescription)
                completion(nil)
            }
        }
    }
}
