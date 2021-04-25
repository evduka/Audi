//
//  RequestCarViewController.swift
//  Audi
//
//  Created by EVGENII DUKA on 25.04.2021.
//

import UIKit

class RequestCarViewController: UIViewController {
    
    @IBOutlet weak var pricesCollectionView: UICollectionView!
    @IBOutlet weak var paymentsCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pricesCollectionView.delegate = self
        pricesCollectionView.dataSource = self
        
        paymentsCollectionView.delegate = self
        paymentsCollectionView.dataSource = self
        
    }
    
}

//MARK: - UICollectionViewDelegate
extension RequestCarViewController: UICollectionViewDelegate {
    
}

//MARK: - UICollectionViewDataSource
extension RequestCarViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = UICollectionViewCell()
        cell.backgroundColor = .red
        
        return cell
    }
    
    
}

//MARK: - iRequestCarView
extension RequestCarViewController: iRequestCarView {
    
}
