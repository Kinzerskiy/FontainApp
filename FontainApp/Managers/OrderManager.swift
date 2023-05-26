//
//  OrderManager.swift
//  FontainApp
//
//  Created by Mac Pro on 16.04.2023.
//

import Foundation
import FirebaseFirestoreSwift
import FirebaseFirestore
import FirebaseAuth

class OrderManager {
    static var orders: [Order] = []
    
    
    func saveOrder(order: Order, completion: @escaping () -> Void) {
        let db = Firestore.firestore()
        guard let data = try? Firestore.Encoder().encode(order) else {
            print("Error encoding order")
            return
        }
        db.collection("Orders").document(order.orderId).setData(data) { error in
            if let error = error {
                print("Error writing order to Firestore: \(error)")
            } else {
                completion()
            }
        }
    }

    
    func getOrder(by index: Int) -> Order {
        OrderManager.orders[index]
    }
    
    func getNumberOfOrders() -> Int {
        return OrderManager.orders.count
    }
    
    func getOrders(completion: @escaping () -> Void) {
        let db = Firestore.firestore()
        let docRef = db.collection("Orders")

        docRef.getDocuments { snapshot, error in
            if let error = error {
                print(error)
                return
            }

            guard let documents = snapshot?.documents else {
                print("No data found")
                return
            }

            var orders = [Order]()

            for document in documents {
                let orderData = document.data()
                let orderId = document.documentID
                let userId = orderData["userId"] as? String
                let productsData = orderData["products"] as? [[String: Any]]
                let address = orderData["address"] as? String

                let isContactDelivery = orderData["isContactDelivery"] as? Bool
                let isNotCalling = orderData["isNotCalling"] as? Bool
                let paymentCompleted = orderData["paymentCompleted"] as? Bool
                let total = orderData["total"] as? Double
                let orderCreatedTimestamp = orderData["orderCreated"] as? Timestamp
                let orderCreated = orderCreatedTimestamp?.dateValue() ?? Date()

                var products = [BasketProduct]()
                if let productsData = productsData {
                    for productData in productsData {
                        if let productDict = productData["product"] as? [String: Any] {
                            do {
                                let jsonData = try JSONSerialization.data(withJSONObject: productDict, options: [])
                                let product = try JSONDecoder().decode(Product.self, from: jsonData)
                                let count = productData["count"] as? Int ?? 0
                                let basketProduct = BasketProduct(product: product, count: count)
                                products.append(basketProduct)
                            } catch {
                                print("Error decoding product: \(error)")
                            }
                        } else {
                            print("Invalid product data format: \(productData)")
                        }
                    }
                }

                let order = Order(orderId: orderId,
                                  userId: userId,
                                  products: products,
                                  address: address,
                                  orderCreated: orderCreated,
                                  isContactDelivey: isContactDelivery,
                                  isNotCalling: isNotCalling,
                                  isContacless: nil,
                                  paymentCompleted: paymentCompleted,
                                  total: total)
                orders.append(order)
            }
            OrderManager.orders = orders
            completion()
        }
    }
}
