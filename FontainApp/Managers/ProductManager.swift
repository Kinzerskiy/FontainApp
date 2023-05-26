//
//  ProductManager.swift
//  FontainApp
//
//  Created by Mac Pro on 16.04.2023.
//

import Foundation
import FirebaseFirestore

class ProductManager {
    
    var models: [Product] = []
    
    func getProducts(completion: @escaping (Error?) -> Void) {
        let db = Firestore.firestore()
        let docRef = db.collection("Product")
        
        docRef.getDocuments { [weak self] data, error in
            if let error = error {
                completion(error)
            }
            guard let data = data else { return }
            self?.models.removeAll()
            
            for document in data.documents {
                let productData = document.data()
                if let price = productData["price"] as? Double,
                   let name = productData["name"] as? String,
                   let productImageUrl = productData["productImageUrl"] as? String,
                   let measure = productData["measure"] as? String {
                   let uuid = document.documentID
                    
                    let product = Product(uuid: uuid, productImageUrl: productImageUrl, name: name, measure: measure, price: price)
                    self?.models.append(product)
                }
            }
            completion(nil)
        }
    }
}
