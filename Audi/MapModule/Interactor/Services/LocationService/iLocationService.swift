//
//  iLocationService.swift
//  Audi
//
//  Created by EVGENII DUKA on 12.04.2021.
//

import Foundation
import CoreLocation

protocol iLocationService {
    func requestLocation(callBack: @escaping (CLLocation?) -> Void)
    func distanceFrom(_ origin: CLLocation, to destination: CLLocation) -> Double
}

