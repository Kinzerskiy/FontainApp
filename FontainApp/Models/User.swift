//
//  User.swift
//  FontainApp
//
//  Created by Mac Pro on 29.04.2023.
//

import Foundation

struct User: Codable {
    var uuid: String?
    var phoneNumber: String?
    var fullName: String?
    var city: String?
    var country: String?
    var street: String?
    var zipCode: String?
    var imageUrl: String?
}
