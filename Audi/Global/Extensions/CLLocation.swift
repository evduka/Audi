//
//  CLLocation.swift
//  Audi
//
//  Created by EVGENII DUKA on 14.04.2021.
//

import Foundation
import CoreLocation

extension CLLocation {
    
    convenience init?(stringValue: String) {
        let arr = stringValue.components(separatedBy: ",")
        let latitude = Double(arr[0])!
        let longitude = Double(arr[1])! 
        self.init(latitude: latitude, longitude: longitude)
    }
    
    var stringValue: String {
        return "\(coordinate.latitude),\(coordinate.longitude)"
    }
    
}
