//
//  BasketViewModel.swift
//  FontainApp
//
//  Created by Mac Pro on 08.05.2023.
//

import Foundation

class BasketViewModel {
    
    var basketModel = OrderCreateModel()
    var dataSource: [DeliverySection] = []
    
    func updateDataSource(completion: @escaping () -> Void) {
        dataSource.removeAll()
        
        let productRows = BasketManager.shared.order.products.map { basketProduct in
            DeliveryRow.product(basketProduct)
        }
        
        dataSource.append(.products(productRows))
        
        let addressTextFieldViewModel = TextFieldCellViewModel.init(address: BasketManager.shared.order.address, completion: { [weak self] address in
            guard let self = self else { return }
            BasketManager.shared.order.address = address
            self.updateDataSource(completion: completion)
        })
        
        let addressTextFieldViewModelRow = DeliveryRow.textField(addressTextFieldViewModel)
        dataSource.append(.textFields(addressTextFieldViewModelRow))
        
        let dontCallSwitcherViewModel = SwitcherCellViewModel(contactlessIsOn: BasketManager.shared.order.isContacless, callIsOn: BasketManager.shared.order.isNotCalling) { [weak self] isOn in
                   guard let self = self else { return }
                   BasketManager.shared.order.isNotCalling = isOn
                   BasketManager.shared.order.isContacless = isOn
                   self.updateDataSource(completion: completion)
               }
        
               dataSource.append(.switchers(dontCallSwitcherViewModel))
        
        let orderTotal = OrederTotalViewModel(total: BasketManager.shared.order.totalPrice)
        dataSource.append(.orderTotal(orderTotal))
    }
}
