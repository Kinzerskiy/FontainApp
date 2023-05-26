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
        addProductView?.isHidden = false
        productItem.isEnabled = true
        self.navigationItem.setHidesBackButton(true, animated: true)
        productPopUp = ItemAddedToCardView.setup(in: addProductView)
        productPopUp?.isHidden = true
    }
}

extension ProductViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        .init(top: 12, left: 10, bottom: 0, right: 10)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
           
            let cellWidth = collectionView.frame.width / 2 - 20
            let cellHeight = cellWidth
            return CGSize(width: cellWidth, height: cellHeight)
        }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.productManager.models.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductCollectionViewCell", for: indexPath) as! ProductCollectionViewCell
        
        let product = viewModel.getProduct(by: indexPath.row)
        cell.layer.cornerRadius = 12
        cell.fill(with: product)
        
        cell.buyComplition = {
            BasketManager.shared.add(product: product)
            
        }
        return cell
    }
    
}
