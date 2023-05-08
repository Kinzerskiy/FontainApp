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
        
        let addressTextFieldViewModel = TextFieldCellViewModel.init(name: "Address", value: BasketManager.shared.order.address, completion: { [weak self] value in
            guard let self = self else { return }
            BasketManager.shared.order.address = value
            self.updateDataSource(completion: completion)
        })
        
        
        let dateTextFieldViewModel = DateCellViewModel.init(date: BasketManager.shared.order.deliveryTime, dateCompletion: { [weak self] date in
            guard let self = self else { return }
            BasketManager.shared.order.deliveryTime = date
            self.updateDataSource(completion: completion)
        })
        
        let commentTextFieldViewModel = TextFieldCellViewModel.init(name: "Comment", value: BasketManager.shared.order.comment) {  [weak self] value in
            guard let self = self else { return }
            BasketManager.shared.order.comment = value
            self.updateDataSource(completion: completion)
        }
        
        let addressTextFieldViewModelRow = DeliveryRow.textField(addressTextFieldViewModel)
        let commentTextFieldViewModelRow = DeliveryRow.textField(commentTextFieldViewModel)
        dataSource.append(.textFields([addressTextFieldViewModelRow, commentTextFieldViewModelRow]))
        
        let dontCallSwitcherViewModel = SwitcherCellViewModel(switcherName: "Do not call me", isOn:  BasketManager.shared.order.isNotCalling) { [weak self] isOn in
            guard let self = self else { return }
            BasketManager.shared.order.isNotCalling = isOn
            self.updateDataSource(completion: completion)
        }
        
        let withoutContactSwitcherVideModel = SwitcherCellViewModel(switcherName: "Without contact", isOn:  BasketManager.shared.order.isContactDelivey) { [weak self] isOn in
            guard let self = self else { return }
            BasketManager.shared.order.isContactDelivey = isOn
            self.updateDataSource(completion: completion)
        }
        
        dataSource.append(.switchers([dontCallSwitcherViewModel, withoutContactSwitcherVideModel]))
        
        let orderTotal = OrederTotalViewModel(total: BasketManager.shared.order.totalPrice, deliveryCoast: BasketManager.shared.order.deliveryCoast)
        dataSource.append(.orderTotal(orderTotal))
        
        
        let paymentMethodCellViewModel = PaymentCellViewModel(value: BasketManager.shared.order.paymentMethod, completion: { [weak self] paymentMethod in
            guard let self = self else { return }
            BasketManager.shared.order.paymentMethod = paymentMethod
            self.updateDataSource(completion: completion)
        })
        dataSource.append(.paymentMethod(paymentMethodCellViewModel))
    }
}
