//
//  Location.swift
//  FontainApp
//
//  Created by Mac Pro on 06.06.2023.
//

import Foundation

struct Location: Codable {
    let latitude: Double
    let longitude: Double
    let title: String
    let snippet: String
    let storeName: String
    let storeAddress: String
    let storePhoto: String?
}
