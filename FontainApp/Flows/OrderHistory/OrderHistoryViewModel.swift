//
//  OrderHistoryViewModel.swift
//  FontainApp
//
//  Created by Mac Pro on 25.05.2023.
//

import Foundation
import Firebase

class OrderHistoryViewModel {
    
   
    
    let orderManager = OrderManager()
    
    func getOrders(completion: @escaping () -> ()) {
        orderManager.getOrders {[weak self] in
            completion()
        }
    }
    
    
    
}
