//
//  etewt.swift
//  Audi
//
//  Created by EVGENII DUKA on 20.04.2021.
//

import Foundation

class Place: NSObject {
    
    var formatted_address: String?
    var geometry: Geometry?
    var name: String?
    var shortName: String {
        guard let text = formatted_address else { return "No short name" }
        let components = text.components(separatedBy: ",")
        return "\(components[0]) \(components[1])"
    }
    
    init(dictionary: [String: Any]) {
        if let formatted_address = dictionary["formatted_address"] as? String {
            self.formatted_address = formatted_address
        }
        if let geometry = dictionary["geometry"] as? [String: Any] {
            self.geometry = Geometry(dictionary: geometry)
        }
        if let name = dictionary["name"] as? String {
            self.name = name
        }
    }
    
    init?(address: Address) {
        self.formatted_address = address.name
        let location = Location(dictionary: ["lat": address.location.coordinate.latitude, "lng": address.location.coordinate.latitude])
        self.geometry = Geometry(dictionary: ["location": location])
        self.name = address.name
    }
    
}

class Geometry: NSObject {
    var location: Location?
    init(dictionary: [String: Any]) {
        if let location = dictionary["location"] as? [String: Any] {
            self.location = Location(dictionary: location)
        }
    }
}

class Location: NSObject {
    var lat: Double?
    var lng: Double?
    init(dictionary: [String: Any]) {
        if let lat = dictionary["lat"] as? Double {
            self.lat = lat
        }
        if let lng = dictionary["lng"] as? Double {
            self.lng = lng
        }
    }
}


