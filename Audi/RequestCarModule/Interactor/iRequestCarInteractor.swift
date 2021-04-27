//
//  iRequestCarInteractor.swift
//  Audi
//
//  Created by EVGENII DUKA on 25.04.2021.
//

import Foundation
import UIKit

enum iRequestCarInteractorLogic {
    case Price, Payment
}

protocol iRequestCarInteractor {
    func collectionViewItemCount(forLogic logic: iRequestCarInteractorLogic) -> Int
    func collectionViewItemSize(forLogic logic: iRequestCarInteractorLogic, andBounds bounds: CGRect) -> CGSize
}
