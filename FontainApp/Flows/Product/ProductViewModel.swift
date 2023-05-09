//
//  ProductViewModel.swift
//  FontainApp
//
//  Created by Mac Pro on 03.05.2023.
//

import Foundation

class ProductViewModel {
    var productManager = ProductManager()
   
    
    func getData(completion: @escaping (Error?) -> Void) {
        productManager.getProducts(completion: completion)
    }
    
    func getProduct(by index: Int) -> Product  {
        return productManager.models[index]
    }
    
    
    
}
