//
//  Route.swift
//  Audi
//
//  Created by EVGENII DUKA on 13.04.2021.
//

import Foundation

struct Route {
    
    var overview_polyline: Polyline?
    
    init(dictionary: [String: Any]) {
        if let overview_polyline = dictionary["overview_polyline"] as? [String: Any] {
            self.overview_polyline = Polyline(dictionary: overview_polyline)
        }
    }
    
    
}


