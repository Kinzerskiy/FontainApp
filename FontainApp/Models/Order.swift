//
//  Order.swift
//  FontainApp
//
//  Created by Mac Pro on 29.04.2023.
//

import Foundation

struct Order: Codable {

    var orderId: String
    var userId: String?
    var products: [BasketProduct]?
    var address: String?
    var comment: String?
    var deliveryTime: Date
    var orderCreated: Date
    var isContactDelivey: Bool?
    var isNotCalling : Bool?
    var paymentCompleted: Bool?
    var total: Double?
}
