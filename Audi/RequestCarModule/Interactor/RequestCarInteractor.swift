//
//  RequestCarInteractor.swift
//  Audi
//
//  Created by EVGENII DUKA on 25.04.2021.
//

import Foundation
import UIKit

class RequestCarInteractor {
    
    private var priceCollectionViewService: iPriceCollectionViewService = PriceCollectionViewService()
    private var paymentCollectionViewService: iPaymentCollectionViewService = PaymentCollectionViewService()
    
}

extension RequestCarInteractor: iRequestCarInteractor {
    
    func collectionViewItemCount(forLogic logic: iRequestCarInteractorLogic) -> Int {
        switch logic {
        case .Price:
            return priceCollectionViewService.getCountOfPrices()
        case .Payment:
            return paymentCollectionViewService.getCountOfPayments()
        }
    }
    
    func collectionViewItemSize(forLogic logic: iRequestCarInteractorLogic, andBounds bounds: CGRect) -> CGSize {
        switch logic {
        case .Price:
            return priceCollectionViewService.getCellSize(forCollectionViewBounds: bounds)
        case .Payment:
            return paymentCollectionViewService.getCellSize(forCollectionViewBounds: bounds)
        }
    }
    
}
