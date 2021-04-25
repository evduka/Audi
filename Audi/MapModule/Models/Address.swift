//
//  Address.swift
//  Audi
//
//  Created by EVGENII DUKA on 18.04.2021.
//

import Foundation
import CoreLocation

class Address: NSObject, NSCoding {
    
    let name: String
    let location: CLLocation
    var shortName: String {
        let components = name.components(separatedBy: ",")
        return "\(components[0]) \(components[1])"
    }
    
    init(name: String, location: CLLocation) {
        self.name = name
        self.location = location
    }
    
    init?(place: Place) {
        guard let name = place.formatted_address else { return nil}
        guard let lat = place.geometry?.location?.lat else { return nil}
        guard let lng = place.geometry?.location?.lng else { return nil}
        let location = CLLocation(latitude: lat, longitude: lng)
        self.name = name
        self.location = location
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.name = aDecoder.decodeObject(forKey: "name") as! String
        let latitude = aDecoder.decodeObject(forKey: "latitude") as! Double
        let longitude = aDecoder.decodeObject(forKey: "longitude") as! Double
        self.location = CLLocation(latitude: latitude, longitude: longitude)
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: "name")
        aCoder.encode(Decimal(location.coordinate.latitude), forKey: "latitude")
        aCoder.encode(Decimal(location.coordinate.longitude), forKey: "longitude")
    }
    
    
}
