//
//  BasketViewModel.swift
//  FontainApp
//
//  Created by Mac Pro on 08.05.2023.
//

import Foundation

class BasketViewModel {
    
    var basketManager = BasketManager.shared
    var dataSource: [DeliverySection] = []
    
    
    func isHaveProducts() -> Bool {
        basketManager.order.products.count > 0
    }
    
    
    func updateDataSource() {
        
        dataSource.removeAll()
        
        let productRows = basketManager.order.products.map { basketProduct in
            DeliveryRow.product(basketProduct)
        }
        dataSource.append(.products(productRows))
        
        let orderTotal = OrderTotalViewModel(total: basketManager.order.totalPrice)
        dataSource.append(.orderTotal(orderTotal))
        
        let addressTextFieldViewModel = TextFieldCellViewModel(address: basketManager.order.address) { [weak self] address in
            self?.basketManager.order.address = address
        }
        dataSource.append(.textField(addressTextFieldViewModel))
        
        let dontCallSwitcherViewModel = SwitcherCellViewModel(
            contactlessIsOn: basketManager.order.isContacless,
            callIsOn: basketManager.order.isNotCalling
        ) { [weak self] isOn in
            self?.basketManager.order.isNotCalling = isOn
            self?.basketManager.order.isContacless = isOn
            
        }
        dataSource.append(.switchers(dontCallSwitcherViewModel))
    }
}
