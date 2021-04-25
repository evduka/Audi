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
    
    var presenter: iRequestCarPresenter?
    var delegate: iRequestCarViewDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(#function)
        
        pricesCollectionView.delegate = self
        pricesCollectionView.dataSource = self
        
        paymentsCollectionView.delegate = self
        paymentsCollectionView.dataSource = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print(#function)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print(#function)
    }
    
}

//MARK: - UICollectionViewDelegate
extension RequestCarViewController: UICollectionViewDelegate {
    
}

//MARK: - UICollectionViewDataSource
extension RequestCarViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
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
