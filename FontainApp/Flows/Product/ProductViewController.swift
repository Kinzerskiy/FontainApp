//
//  ProductViewController.swift
//  FontainApp
//
//  Created by Mac Pro on 27.04.2023.
//

import UIKit
import Kingfisher

class ProductViewController: UIViewController {

    @IBOutlet weak var productItem: UITabBarItem!
    @IBOutlet weak var productCollectionView: UICollectionView!
    @IBOutlet weak var addProductView: UIView!
    
    var productPopUp: ItemAddedToCardView?
    var viewModel = ProductViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareUI()
       
        prepareCollectionView()
        getData()
    }
    
    func getData() {
        viewModel.getData { [weak self] error in
            if let error = error {
                print(error)
            } else {
                self?.productCollectionView.reloadData()
            }
        }
    }
    
    func prepareCollectionView() {
        
        productCollectionView.delegate = self
        productCollectionView.dataSource = self
        
        productCollectionView.register(.init(nibName: "ProductCollectionViewCell", bundle: .main), forCellWithReuseIdentifier: "ProductCollectionViewCell")
    }
    
    func prepareUI() {
        addProductView?.isHidden = true
        self.navigationItem.setHidesBackButton(true, animated: true)
        
    }

}

extension ProductViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.productManager.models.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductCollectionViewCell", for: indexPath) as! ProductCollectionViewCell
        
        let product = viewModel.getProduct(by: indexPath.row)
        cell.fill(with: product)
        
        cell.buyComplition = {
            BasketManager.shared.add(product: product)
            
        }
        return cell
    }
    
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
            .init(width: 200, height: 200)
        }
}
