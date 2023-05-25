//
//  OrderHistoryViewController.swift
//  FontainApp
//
//  Created by Mac Pro on 25.05.2023.
//

import UIKit

class OrderHistoryViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    let viewModel = OrderHistoryViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(.init(nibName: "OrderHistoryCollectionViewCell", bundle: .main), forCellWithReuseIdentifier: "OrderHistoryCollectionViewCell")
        
        viewModel.getOrders {
            self.collectionView.reloadData()
        }
    }

}


extension OrderHistoryViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.orderManager.getNumberOfOrders()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "OrderHistoryCollectionViewCell", for: indexPath) as! OrderHistoryCollectionViewCell
        
        cell.fill(with: viewModel.orderManager.getOrder(by: indexPath.row))
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        .init(width: collectionView.frame.width - 40 , height: 100)
    }
    
    
    
}
