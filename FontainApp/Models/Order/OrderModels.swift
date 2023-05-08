//
//  OrderModels.swift
//  FontainApp
//
//  Created by Mac Pro on 30.04.2023.
//

import Foundation

struct OrderCreateModel {
    
   var orderId = String(Int.random(in: 1...1000000))
   var userId: String?
   var products: [BasketProduct] = []
   var address: String = ""
   var comment: String = ""
   var deliveryTime: Date = Date()
    var orderCreatedDate: Date = Date()
   var isContactDelivey: Bool = false
   var isNotCalling : Bool = false
   var totalPrice: Double { BasketManager.shared.getPrice() }
   var deliveryCoast: Double = 50.0
   var paymentMethod: PaymentMethod = .cash
   }

enum DeliveryRow {
    case product(BasketProduct)
    case textField(TextFieldCellViewModel)
    case switcher(SwitcherCellViewModel)
    case date(DateCellViewModel)
}

enum DeliverySection {
    case products([DeliveryRow])
    case textFields([DeliveryRow])
    case switchers([SwitcherCellViewModel])
    case date(DateCellViewModel)
    case orderTotal(OrederTotalViewModel)
    case paymentMethod(PaymentCellViewModel)
    case privacy(String)
}

class DateCellViewModel {
    var date: Date = Date()
    var dateCompletion: ((Date) -> Void)?
    
    init(date: Date, dateCompletion: @escaping (Date) -> Void) {
        self.date = date
        self.dateCompletion = dateCompletion
    }
}

class TextFieldCellViewModel {
    var name: String = ""
    var value: String = ""
    var completion: ((String) -> Void)
    
    init(name: String, value: String, completion: @escaping (String) -> Void) {
        self.name = name
        self.value = value
        self.completion = completion
    }
}

class SwitcherCellViewModel {
    var switcherName: String = ""
    var isOn: Bool = false
    var completion: ((Bool) -> Void)?
    
    init(switcherName: String, isOn: Bool, completion: @escaping (Bool) -> Void) {
        self.switcherName = switcherName
        self.isOn = isOn
        self.completion = completion
    }
}

class OrederTotalViewModel {
    var total: Double = 0.0
    var deliveryCoast = 0.0
    
    init(total: Double, deliveryCoast: Double = 0.0) {
        self.total = total
        self.deliveryCoast = deliveryCoast
    }
}

class PaymentCellViewModel {
    var value: PaymentMethod
    var completion: ((PaymentMethod) -> Void)?
    
    init(value: PaymentMethod, completion: @escaping ((PaymentMethod) -> Void)) {
        self.value = value
        self.completion = completion
    }
}

enum PaymentMethod: Int {
    case card, cash
}
