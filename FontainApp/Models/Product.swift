//
//  Product.swift
//  FontainApp
//
//  Created by Mac Pro on 29.04.2023.
//

import Foundation

struct Product: Codable {
    let uuid: String
    let imageName: String
    let name: String
    let measure: String
    let price: Double
}
