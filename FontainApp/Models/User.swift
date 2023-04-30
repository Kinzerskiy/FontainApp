//
//  User.swift
//  FontainApp
//
//  Created by Mac Pro on 29.04.2023.
//

import Foundation
struct User: Codable {
    let uuid: String
    let phoneNumber: String?
    let fullName: String?
    let address: String?
    let imageUrl: String?
}
