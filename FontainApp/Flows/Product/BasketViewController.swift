//
//  BasketViewController.swift
//  FontainApp
//
//  Created by Mac Pro on 07.05.2023.
//

import UIKit

class BasketViewController: UIViewController {

    @IBOutlet weak var toShopButton: UIButton!
    @IBOutlet weak var emptyLabel: UILabel!
    @IBOutlet weak var emptyImage: UIImageView!
    
    @IBOutlet weak var basketTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    @IBAction func basketAction(_ sender: Any) {
        
    }
    
}








extension BasketViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch dataSource[section] {
        case .products(let products): return products.count
        case .switchers(let switchers): return switchers.count
        case .textFields(let textFields): return textFields.count
        default: return 1
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch dataSource[indexPath.section] {
        case .products(let products):
            let productRow = products[indexPath.row]
            switch productRow {
            case .product(let product):
                let cell = tableView.dequeueReusableCell(withIdentifier: "BasketTableViewCell", for: indexPath) as! BasketTableViewCell
                cell.fill(with: product)
                cell.selectionStyle = .none
                
                cell.addCompletion = { [weak self] in
                    BasketManager.shared.plusProduct(by: indexPath.row)
                    self?.updateDataSource()
                }
                
                cell.removeCompletion = { [weak self] in
                    BasketManager.shared.minusProduct(by: indexPath.row)
                    self?.updateDataSource()
                }
                return cell
                
            default: return UITableViewCell()
            }
            
        case .textFields(let textFields):
            let textFieldRow = textFields[indexPath.row]
            switch textFieldRow {
            case .textField(let textField):
                
                let cell = tableView.dequeueReusableCell(withIdentifier: "TextFieldTableViewCell", for: indexPath) as! TextFieldTableViewCell
                cell.fill(with: textField)
                
                return cell
                
            default: return UITableViewCell()
            }
            
        case .switchers(let switchers):
            
            let switcherRow = switchers[indexPath.row]
            switch switcherRow {
            case (let switcherViewModel):
                
                let cell = tableView.dequeueReusableCell(withIdentifier: "SwitcherTableViewCell", for: indexPath) as! SwitcherTableViewCell
                cell.fill(with: switcherViewModel)
                
                return cell
                
            }
            
        case .orderTotal(let orderTotal):
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "OrderTotalTableViewCell", for: indexPath) as! OrderTotalTableViewCell
            cell.fill(with: orderTotal)
            return cell
            
        case .date(let date):
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "DateTableViewCell", for: indexPath) as! DateTableViewCell
            cell.fill(with: date)
            return cell
            
            
        case .paymentMethod(let paymentMethod):
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "PaymentMethodTableViewCell", for: indexPath) as! PaymentMethodTableViewCell
            cell.fill(with: paymentMethod)
            return cell
            
        case .privacy(let privacyText): return UITableViewCell()
            
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch dataSource[indexPath.section] {
        case .products: return 150
        case .switchers: return 50
        case .textFields: return 70
        case .date: return 70
        case .orderTotal: return 120
        case .paymentMethod: return 70
        case .privacy: return 50
        }
    }
}
