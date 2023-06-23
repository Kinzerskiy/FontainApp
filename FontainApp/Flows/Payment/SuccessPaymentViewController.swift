//
//  SuccessPaymentViewController.swift
//  FontainApp
//
//  Created by Mac Pro on 23.06.2023.
//

import UIKit

class SuccessPaymentViewController: UIViewController {
    
    @IBOutlet weak var orderNumberLabel: UILabel!
    @IBOutlet weak var orderDateLabel: UILabel!
    @IBOutlet weak var okButton: UIButton!
    
    var order: Order!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareUI()
       
    }
    
    func prepareUI() {
        navigationItem.setHidesBackButton(true, animated: true)
        okButton.activeStyle()
        orderNumberLabel.text = "Your order number is #\(order.orderId)"
        
        let calendar = Calendar.current
        let orderCreated = order.orderCreated
        let oneDayLater = calendar.date(byAdding: .day, value: 1, to: orderCreated)
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US")
        dateFormatter.dateFormat = "d MMMM"
        let oneDayLaterString = dateFormatter.string(from: oneDayLater!)
        
        orderDateLabel.text = "We’re preparing your order, it will be delivered on \(oneDayLaterString). Relax and wait for your order to be delivered to your home."
    }
    
    
    @IBAction func okButtonPressed(_ sender: Any) {
        BasketManager.shared.removeAllProducts()
        
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = mainStoryboard.instantiateViewController(withIdentifier: "MainTabBar") as! UITabBarController
        let navigationController = UINavigationController(rootViewController: viewController)
        
        UIApplication.shared.windows.first?.rootViewController = navigationController
        UIApplication.shared.windows.first?.makeKeyAndVisible()
    }
}
