//
//  iRequestCarPresenter.swift
//  Audi
//
//  Created by EVGENII DUKA on 25.04.2021.
//

import Foundation
import UIKit

protocol iRequestCarPresenter: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func setCollectionViews(_ collectionViews: [UICollectionView])
}

