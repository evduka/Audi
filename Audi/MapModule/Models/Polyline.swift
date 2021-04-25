//
//  Polyline.swift
//  Audi
//
//  Created by EVGENII DUKA on 13.04.2021.
//

import Foundation

struct Polyline {
    
    var points: String?
    
    init(dictionary: [String: Any]) {
        if let points = dictionary["points"] as? String {
            self.points = points
        }
    }
    
}
