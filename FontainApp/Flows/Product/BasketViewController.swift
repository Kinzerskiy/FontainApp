//
//  BasketViewController.swift
//  FontainApp
//
//  Created by Mac Pro on 07.05.2023.
//

import UIKit
import Kingfisher

class BasketViewController: UIViewController {
    
    @IBOutlet weak var toShopButton: UIButton!
    @IBOutlet weak var emptyLabel: UILabel!
    @IBOutlet weak var emptyImage: UIImageView!
    @IBOutlet weak var basketTableView: UITableView!
    
    var dataSource: [DeliverySection] = []
    
    var basketViewModel = BasketViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateDataSource()
    }
    
    func updateDataSource() {
        basketViewModel.updateDataSource()
        dataSource = basketViewModel.dataSource
        
        basketTableView.isHidden = !basketViewModel.isHaveProducts()
        emptyImage.isHidden = basketViewModel.isHaveProducts()
        emptyLabel.isHidden = basketViewModel.isHaveProducts()
       
        if basketViewModel.isHaveProducts() {
                toShopButton.setTitle("Checkout", for: .normal)
            } else {
                toShopButton.setTitle("To shop", for: .normal)
            }
        
        basketTableView.reloadData()
    }
    
    func prepareUI() {
        basketTableView.separatorStyle = .none
        basketTableView.delegate = self
        basketTableView.dataSource = self
        
        toShopButton.layer.cornerRadius = 12
        
        basketTableView.register(.init(nibName: "TotalProductTableViewCell", bundle: nil), forCellReuseIdentifier: "TotalProductTableViewCell")
        basketTableView.register(.init(nibName: "TotalTableViewCell", bundle: nil), forCellReuseIdentifier: "TotalTableViewCell")
        basketTableView.register(.init(nibName: "DeliveryInfoTableViewCell", bundle: nil), forCellReuseIdentifier: "DeliveryInfoTableViewCell")
        basketTableView.register(.init(nibName: "DeliveryAdressTableViewCell", bundle: nil), forCellReuseIdentifier: "DeliveryAdressTableViewCell")
        
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(hideKeyboard)))
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification: )), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
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
    
    @IBAction func basketAction(_ sender: Any) {
      
        if toShopButton.titleLabel?.text == "Checkout" {
            let order = Order(orderId: BasketManager.shared.order.orderId, userId: BasketManager.shared.order.userId, products: BasketManager.shared.order.products, address: BasketManager.shared.order.address, orderCreated: Date(), isContactDelivey: BasketManager.shared.order.isContactDelivey, isNotCalling: BasketManager.shared.order.isNotCalling, isContacless: BasketManager.shared.order.isContacless, paymentCompleted: false, total: BasketManager.shared.getPrice())
            
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "CardViewController") as! CardViewController
            vc.order = order
            self.navigationController?.pushViewController(vc, animated: true)
           } else {
               let vc = self.storyboard?.instantiateViewController(withIdentifier: "ProductViewController") as! ProductViewController
               self.navigationController?.pushViewController(vc, animated: true)
           }
    }
    
}

extension BasketViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch dataSource[section] {
        case .products(let products): return products.count
        case .orderTotal(_): return 1
        case .textField(_): return 1
        case .switchers(_): return 1
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
         
                
                
                cell.addCompletion = { [weak self] in
                    BasketManager.shared.plusProduct(by: indexPath.row)
                    self?.updateDataSource()
                    self?.basketTableView.reloadData()
                }
                
                cell.removeCompletion = { [weak self] in
                    BasketManager.shared.minusProduct(by: indexPath.row)
                    self?.updateDataSource()
                    self?.basketTableView.reloadData()
                }
                
                cell.removeAllCompletion = { [weak self] in
                    BasketManager.shared.removeProduct(at: indexPath.row)
                    self?.updateDataSource()
                    self?.basketTableView.reloadData()
                }
                
                return cell
                
            default: return UITableViewCell()
            }
            
        case .orderTotal(let orderTotal):
            let cell = tableView.dequeueReusableCell(withIdentifier: "TotalTableViewCell", for: indexPath) as! TotalTableViewCell
            cell.fill(with: orderTotal)
            return cell
            
        case .textField(let textField):
            let cell = tableView.dequeueReusableCell(withIdentifier: "DeliveryAdressTableViewCell", for: indexPath) as! DeliveryAdressTableViewCell
            cell.fill(with: textField)
            return cell
            
        case .switchers(let switcher):
            let cell = tableView.dequeueReusableCell(withIdentifier: "DeliveryInfoTableViewCell", for: indexPath) as! DeliveryInfoTableViewCell
            cell.fill(with: switcher)
            
            return cell
        }
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch dataSource[indexPath.section] {
        case .products: return 150
        case .orderTotal: return 48
        case .textField: return 80
        case .switchers: return 121
        }
    }
}
