//
//  iPriceCollectionViewService.swift
//  Audi
//
//  Created by EVGENII DUKA on 28.04.2021.
//

import Foundation
import UIKit

protocol iPriceCollectionViewService {
    func getCountOfPrices() -> Int
    func getCellSize(forCollectionViewBounds bounds: CGRect) -> CGSize
}
