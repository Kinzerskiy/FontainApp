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
        navigationItem.setHidesBackButton(true, animated: true)
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(.init(nibName: "OrderHistoryCollectionViewCell", bundle: .main), forCellWithReuseIdentifier: "OrderHistoryCollectionViewCell")
        
        viewModel.getOrders {
            self.collectionView.reloadData()
        }
    }
}


extension OrderHistoryViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UITabBarControllerDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.orderManager.getNumberOfOrders()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "OrderHistoryCollectionViewCell", for: indexPath) as! OrderHistoryCollectionViewCell
        
        cell.fill(with: viewModel.orderManager.getOrder(by: indexPath.row))
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapOrderCell(_:)))
        cell.addGestureRecognizer(tapGesture)
        
        return cell
    }
    
    
    
    @objc func didTapOrderCell(_ gestureRecognizer: UITapGestureRecognizer) {
        guard let cell = gestureRecognizer.view as? UICollectionViewCell,
              let indexPath = collectionView.indexPath(for: cell) else { return }
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "OrderDetailsViewController") as! OrderDetailsViewController
        let order = viewModel.orderManager.getOrder(by: indexPath.row)
        
        vc.order = order
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        .init(width: collectionView.frame.width - 40 , height: 100)
    }
}
