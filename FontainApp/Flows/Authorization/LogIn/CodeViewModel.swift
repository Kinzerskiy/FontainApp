//
//  CodeViewModel.swift
//  FontainApp
//
//  Created by Mac Pro on 26.04.2023.
//

import Foundation
import Firebase

class CodeViewModel {
    
    var verificationID: String
    
    init(verificationID: String) {
        self.verificationID = verificationID
    }
    
    func authUserWithCode(code: String, completion: @escaping () -> ()) {
        let credential = PhoneAuthProvider.provider().credential(
            withVerificationID: verificationID,
            verificationCode: code)
        
        Auth.auth().signIn(with: credential) { _, error in
            if error != nil {
                print(error?.localizedDescription ?? "error")
            } else {
                guard Auth.auth().currentUser != nil else { return }
                completion()
            }
        }
    }
}


