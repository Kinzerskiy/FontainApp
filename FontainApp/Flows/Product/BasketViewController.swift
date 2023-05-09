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
    
    var productInBasket: [BasketProduct] = []
    var dataSource: [DeliverySection] = []
    
    var basketViewModel = BasketViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareUI()
        updateDataSource()
    }
    
    func updateDataSource() {
        basketViewModel.updateDataSource { [weak self] in
            self?.dataSource = self?.basketViewModel.dataSource ?? []
            self?.basketTableView.reloadData()
        }
    }
    
    func prepareUI() {
        basketTableView.delegate = self
        basketTableView.dataSource = self
        
        basketTableView.register(.init(nibName: "TotalProductTableViewCell", bundle: nil), forCellReuseIdentifier: "TotalProductTableViewCell")
        basketTableView.register(.init(nibName: "TotalTableViewCell", bundle: nil), forCellReuseIdentifier: "TotalTableViewCell")
        basketTableView.register(.init(nibName: "DeliveryInfoTableViewCell", bundle: nil), forCellReuseIdentifier: "DeliveryInfoTableViewCell")
        basketTableView.register(.init(nibName: "DeliveryAdressTableViewCell", bundle: nil), forCellReuseIdentifier: "DeliveryAdressTableViewCell")
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
        case .switchers(_): return 1
        case .textFields(_): return 1
        default: return 0
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
                let cell = tableView.dequeueReusableCell(withIdentifier: "TotalProductTableViewCell", for: indexPath) as! TotalProductTableViewCell
                cell.fill(with: product)
                cell.selectionStyle = .none
                
                cell.addCompletion = { [weak self] in
                    BasketManager.shared.plusProduct(by: indexPath.row)
                    self?.basketViewModel.updateDataSource(completion: {
                        tableView.reloadData()
                    })
                }
                
                cell.removeCompletion = { [weak self] in
                    BasketManager.shared.minusProduct(by: indexPath.row)
                    self?.basketViewModel.updateDataSource(completion: {
                        tableView.reloadData()
                    })
                }
                return cell
                
            default: return UITableViewCell()
            }
            
        case .textFields(let textFields):
            let textFieldRow = textFields
            switch textFieldRow {
            case .textField(let textField):
                
                let cell = tableView.dequeueReusableCell(withIdentifier: "DeliveryAdressTableViewCell", for: indexPath) as! DeliveryAdressTableViewCell
                cell.fill(with: textField)
                
                return cell
                
            default: return UITableViewCell()
            }
            
        case .switchers(let switcher):
            let cell = tableView.dequeueReusableCell(withIdentifier: "DeliveryInfoTableViewCell", for: indexPath) as! DeliveryInfoTableViewCell
            cell.fill(with: switcher)
            
            return cell
            
        case .orderTotal(let orderTotal):
            let cell = tableView.dequeueReusableCell(withIdentifier: "TotalTableViewCell", for: indexPath) as! TotalTableViewCell
            cell.fill(with: orderTotal)
            return cell
        }
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch dataSource[indexPath.section] {
        case .products: return 150
        case .switchers: return 50
        case .textFields: return 70
        case .orderTotal: return 120
        }
    }
}
