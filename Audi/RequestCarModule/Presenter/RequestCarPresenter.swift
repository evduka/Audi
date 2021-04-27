//
//  RequestCarPresenter.swift
//  Audi
//
//  Created by EVGENII DUKA on 25.04.2021.
//

import Foundation
import UIKit

class RequestCarPresenter: NSObject {
    
    private weak var view: iRequestCarView?
    private var interactor: iRequestCarInteractor?
    private weak var pricesCollectionView: UICollectionView?
    private weak var paymentsCollectionView: UICollectionView?
    
    init(view: iRequestCarView, interactor: iRequestCarInteractor) {
        self.view = view
        self.interactor = interactor
        super.init()
        view.presenter = self
        view.delegate = self
    }
    
}

//MARK: - iRequestCarPresenter
extension RequestCarPresenter: iRequestCarPresenter {
    
    func setCollectionViews(_ collectionViews: [UICollectionView]) {
        guard collectionViews.count > 1 else { return }
        pricesCollectionView = collectionViews[0]
        paymentsCollectionView = collectionViews[1]
        pricesCollectionView?.dataSource = self
        pricesCollectionView?.delegate = self
        paymentsCollectionView?.dataSource = self
        paymentsCollectionView?.delegate = self
    }
    
}

//MARK: - iRequestCarViewDelegate
extension RequestCarPresenter: iRequestCarViewDelegate {
    
    func viewDidLoad() {
        
    }
    
    func backgroundColoredViewDidTap() {
        view?.hideViewAnimated { [weak self] in
            self?.view?.dismissFromParent()
        }
    }
    
}

//MARK: - UICollectionViewDelegate
extension RequestCarPresenter: UICollectionViewDelegate {
    
    
}

//MARK: - UICollectionViewDataSource
extension RequestCarPresenter: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        guard let interactor = interactor else { return 0 }
        
        if collectionView == pricesCollectionView {
            return interactor.collectionViewItemCount(forLogic: .Price)
        } else {
            return interactor.collectionViewItemCount(forLogic: .Payment)
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        
        return cell
    }
    
}

//MARK: - UICollectionViewDelegateFlowLayout
extension RequestCarPresenter: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        guard let interactor = interactor else { return .zero }
        
        if collectionView == pricesCollectionView {
            return interactor.collectionViewItemSize(forLogic: .Price, andBounds: collectionView.bounds)
        } else {
            return interactor.collectionViewItemSize(forLogic: .Payment, andBounds: collectionView.bounds)
        }
        
    }
    
}
