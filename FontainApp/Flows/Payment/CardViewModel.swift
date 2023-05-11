//
//  CardViewModel.swift
//  FontainApp
//
//  Created by Mac Pro on 11.05.2023.
//

import Foundation
import Cloudipsp


class CardViewModel {
    
     func payOrder() {
         
//        guard let card = self.cardInputLayout.confirm() else {
//            debugPrint("Empty card")
//            let alert = UIAlertController(title: "Please add card", message: nil, preferredStyle: .alert)
//            let cancel = UIAlertAction(title: "OK", style: .cancel)
//            alert.addAction(cancel)
//            self.present(alert, animated: true)
//            return
//        }
//
//        let cloudipspApi = PSCloudipspApi(merchant: Int(merchantIDTextField.text!) ?? 0, andCloudipspView: cloudipspWebView)
//        let generatedOrderId = String(order.orderId)
//        let amount = (order.total ?? 0) * 100
//        let paymentOrder = PSOrder(order: Int(amount), aStringCurrency: "UAH", aIdentifier: generatedOrderId, aAbout: descriptionTextField.text!)
//        cloudipspApi?.pay(card, with: paymentOrder, andDelegate: self)
    }
    
    
        
    func saveOrder() {
//        let orderManager = OrderManager()
//
//
//
//        orderManager.saveOrder(order: order) { [weak self] in
//            DispatchQueue.main.async {
//                self?.navigationController?.popToRootViewController(animated: true)
                
//            }
//        }
    }
}
