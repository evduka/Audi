//
//  PaymentCollectionViewService.swift
//  Audi
//
//  Created by EVGENII DUKA on 28.04.2021.
//

import Foundation
import UIKit

class PaymentCollectionViewService {
    
}

//MARK: - iPaymentCollectionViewService
extension PaymentCollectionViewService: iPaymentCollectionViewService {
    
    func getCountOfPayments() -> Int {
        return 2
    }
    
    func getCellSize(forCollectionViewBounds bounds: CGRect) -> CGSize {
        return CGSize(width: bounds.width/2, height: bounds.height)
    }
    
}
