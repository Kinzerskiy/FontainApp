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
        
        let addressTextFieldViewModel = TextFieldCellViewModel(address: basketManager.order.address) { [weak self] address in
            self?.basketManager.order.address = address
            
        }
        
        let addressTextFieldViewModelRow = DeliveryRow.textField(addressTextFieldViewModel)
        dataSource.append(.textFields(addressTextFieldViewModelRow))
        
        let dontCallSwitcherViewModel = SwitcherCellViewModel(
            contactlessIsOn: basketManager.order.isContacless,
            callIsOn: basketManager.order.isNotCalling
        ) { [weak self] isOn in
            self?.basketManager.order.isNotCalling = isOn
            self?.basketManager.order.isContacless = isOn
            
        }
        
        dataSource.append(.switchers(dontCallSwitcherViewModel))
        
        let orderTotal = OrederTotalViewModel(total: basketManager.order.totalPrice)
        dataSource.append(.orderTotal(orderTotal))
    }
}
