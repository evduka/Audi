//
//  PlaceHttpService.swift
//  Audi
//
//  Created by EVGENII DUKA on 20.04.2021.
//

import Foundation

class PlaceHttpService: iPlaceHttpService {
    
    var link: String = "https://maps.googleapis.com"
    
    var path: String = "maps/api/place/textsearch/json"
    
    var httpMethod: String = "get"
    
    var params: [String : String]?
    
    var HTTPHeaders: [String : String]?
    
    var urlSessionDataTast: URLSessionDataTask?
    
}
