//
//  CardViewController.swift
//  FontainApp
//
//  Created by Mac Pro on 11.05.2023.
//

import UIKit
import Cloudipsp

class CardViewController: UIViewController, PSPayCallbackDelegate {

    @IBOutlet weak var merchantIDTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet weak var cardInputLayout: PSCardInputLayout!
    
    var cloudipspWebView: PSCloudipspWKWebView!

//    let viewModel = CardViewModel()
    var order: Order!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        prepareUI()
    }
    
    
    func prepareUI() {
        cloudipspWebView = PSCloudipspWKWebView(frame: CGRect(x: 0, y: 64, width: self.view.bounds.width, height: self.view.bounds.height))
        self.view.addSubview(cloudipspWebView)
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification: )), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func saveOrder() {
        let orderManager = OrderManager()
        
        orderManager.saveOrder(order: order) {
            DispatchQueue.main.async {
                let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let viewController = mainStoryboard.instantiateViewController(withIdentifier: "MainTabBar") as! UITabBarController
                let navigationController = UINavigationController(rootViewController: viewController)
            }
        }
    }

    
    private func payOrder() {
        
        guard let card = self.cardInputLayout.confirm() else {
            debugPrint("Empty card")
            let alert = UIAlertController(title: "Please add card", message: nil, preferredStyle: .alert)
            let cancel = UIAlertAction(title: "OK", style: .cancel)
            alert.addAction(cancel)
            self.present(alert, animated: true)
            return
        }
        
        let cloudipspApi = PSCloudipspApi(merchant: Int(merchantIDTextField.text!) ?? 0, andCloudipspView: cloudipspWebView)
        let generatedOrderId = String(order.orderId)
        let amount = (order.total ?? 0) * 100
        let paymentOrder = PSOrder(order: Int(amount), aStringCurrency: "UAH", aIdentifier: generatedOrderId, aAbout: descriptionTextField.text!)
        cloudipspApi?.pay(card, with: paymentOrder, andDelegate: self)
    }
    
    @objc private func hideKeyboard() {
        self.view.endEditing(true)
    }
    
    @objc private func keyboardWillShow(notification: NSNotification) {
        self.view.frame.origin.y = view.frame.origin.y - 100
    }
    
    @objc private func keyboardWillHide() {
        self.view.frame.origin.y = 0
    }
    
    @IBAction func onPayPressed(_ sender: Any) {
                
        
            guard let merchantIDString = merchantIDTextField.text,
                    let merchantID = Int(merchantIDString), merchantID > 0
        else { debugPrint("Invalid merchant ID")
                return }
            
            guard let description = descriptionTextField.text,
                    !description.isEmpty else {
                debugPrint("Description is required")
                return
            }
        payOrder()
        saveOrder()
    }
    
    
    @IBAction func onTestCardPressed(_ sender: Any) {
        self.cardInputLayout.test()
    }

    func onPaidProcess(_ receipt: PSReceipt!) {
        debugPrint("onPaidProcess: %@", receipt.status)
        if receipt.status.rawValue == 4 {
            saveOrder()
        }
    }
    
    func onPaidFailure(_ error: Error!) {
        debugPrint("onPaidFailure: %@", error.localizedDescription)
    }
    
    func onWaitConfirm() {
        debugPrint("onWaitConfirm")
    }
    
}
