//
//  OrderDetailsViewController.swift
//  FontainApp
//
//  Created by Mac Pro on 26.05.2023.
//

import UIKit
import FirebaseAuth
import FirebaseFirestoreSwift
import FirebaseFirestore

class OrderDetailsViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var repeatOrderButton: UIButton!
    @IBOutlet weak var orderTotalLabel: UILabel!
    
    var order: Order?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.setHidesBackButton(true, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        repeatOrderButton.activeStyle()
        
        if let total = order?.total?.description {
            orderTotalLabel.text = String("€ \(total)")
        } else {
            orderTotalLabel.text = "€ 0"
        }
        
        tableView.register(.init(nibName: "OrderDetailsHeaderTableViewCell", bundle: nil), forCellReuseIdentifier: "OrderDetailsHeaderTableViewCell")
        
        tableView.register(.init(nibName: "PreviousOrderTableViewCell", bundle: nil), forCellReuseIdentifier: "PreviousOrderTableViewCell")
    }
   
        
    @IBAction func repeatOrderAction(_ sender: Any) {
        let orderManager = OrderManager()
        guard let order = order else { return }
        var newOrder = Order(
            orderId: String(Int.random(in: 1...1000000)),
            products: order.products,
            address: order.address,
            orderCreated: Date(),
            isContactDelivey: order.isContactDelivey,
            isNotCalling: order.isNotCalling,
            isContacless: order.isContacless,
            paymentCompleted: false,
            total: order.total)
        
        
        orderManager.saveOrder(order: newOrder) {
            let alert = UIAlertController(title: "Thanks, the same order was created", message: nil, preferredStyle: .alert)
            let cancel = UIAlertAction(title: "OK", style: .cancel) { cancel in
                    BasketManager.shared.order = OrderCreateModel()
                self.navigationController?.popToRootViewController(animated: true)
            }
            alert.addAction(cancel)
            self.present(alert, animated: true, completion: nil)
        }
        
    }
}


extension OrderDetailsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            
            return order?.products?.count ?? 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "OrderDetailsHeaderTableViewCell", for: indexPath) as! OrderDetailsHeaderTableViewCell
            if let order = order {
                cell.fill(with: order)
            }
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "PreviousOrderTableViewCell", for: indexPath) as! PreviousOrderTableViewCell
            if let product = order?.products?[indexPath.row] {
                cell.fill(with: product)
            }
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 120
        } else {
            return 120
        }
    }
}
