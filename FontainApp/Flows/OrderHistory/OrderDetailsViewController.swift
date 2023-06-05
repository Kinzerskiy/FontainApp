//
//  OrderDetailsViewController.swift
//  FontainApp
//
//  Created by Mac Pro on 26.05.2023.
//

import UIKit

class OrderDetailsViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
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
        
        tableView.register(.init(nibName: "OrderDetailsHeaderTableViewCell", bundle: nil), forCellReuseIdentifier: "OrderDetailsHeaderTableViewCell")
        
        tableView.register(.init(nibName: "PreviousOrderTableViewCell", bundle: nil), forCellReuseIdentifier: "PreviousOrderTableViewCell")
        
        
    }
    
    
    @IBAction func repeatOrderButton(_ sender: Any) {
        
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
            if let product = order?.products?[indexPath.row].product {
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
