//
//  GoogleMapManager.swift
//  FontainApp
//
//  Created by Mac Pro on 06.06.2023.
//

import Foundation
import FirebaseFirestoreSwift
import FirebaseFirestore

class GoogleMapManager {
    let db = Firestore.firestore()
    
    func getStoreLocations(completion: @escaping ([Location]?) -> Void) {
        let collectionRef = db.collection("StoreLocations")
        collectionRef.getDocuments { (querySnapshot, error) in
            if let error = error {
                print("Error getting store locations: \(error)")
                completion(nil)
            } else {
                var locations: [Location] = []
                for document in querySnapshot?.documents ?? [] {
                    let locationData = document.data()
                    do {
                        let jsonData = try JSONSerialization.data(withJSONObject: locationData, options: [])
                        let location = try JSONDecoder().decode(Location.self, from: jsonData)
                        locations.append(location)
                    } catch {
                        print("Error decoding location: \(error)")
                    }
                }
                completion(locations)
            }
        }
    }
}
