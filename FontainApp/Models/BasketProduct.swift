//
//  BasketProduct.swift
//  FontainApp
//
//  Created by Mac Pro on 08.05.2023.
//

import Foundation

class BasketProduct: Codable {
    var product: Product
    var count: Int
    
    init(product: Product, count: Int) {
        self.product = product
        self.count = count
    }
}
