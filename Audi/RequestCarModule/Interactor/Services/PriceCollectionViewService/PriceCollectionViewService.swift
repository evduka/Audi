//
//  PriceCollectionViewService.swift
//  Audi
//
//  Created by EVGENII DUKA on 28.04.2021.
//

import Foundation
import UIKit

class PriceCollectionViewService {
    
}

//MARK: - iPriceCollectionViewService
extension PriceCollectionViewService: iPriceCollectionViewService {
    
    func getCountOfPrices() -> Int {
        return 10
    }
    
    func getCellSize(forCollectionViewBounds bounds: CGRect) -> CGSize {
        return CGSize(width: bounds.width/3, height: bounds.height)
    }
    
}
