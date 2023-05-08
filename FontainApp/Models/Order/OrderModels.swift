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
    var address: String = ""
    var completion: ((String) -> Void)
    
    init(address: String, completion: @escaping (String) -> Void) {
        self.address = address
        self.completion = completion
    }
}

class SwitcherCellViewModel {
    var contactlessIsOn: Bool = false
    var callIsOn: Bool = false
    
    var contactlessSwitchCompletion: ((Bool) -> Void)?
    var callSwitchCompletion: ((Bool) -> Void)?
    
    init(contactlessIsOn: Bool, callIsOn: Bool, completion: @escaping (Bool) -> Void) {
        self.contactlessIsOn = contactlessIsOn
        self.callIsOn = callIsOn
        self.contactlessSwitchCompletion = completion
        self.callSwitchCompletion = completion
    }
}

class OrederTotalViewModel {
    var total: Double = 0.0
    
    init(total: Double) {
        self.total = total
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
