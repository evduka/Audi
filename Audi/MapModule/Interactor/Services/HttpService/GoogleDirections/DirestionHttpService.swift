//
//  DirectionHttpService.swift
//  Audi
//
//  Created by EVGENII DUKA on 13.04.2021.
//

import Foundation

class DirectionHttpService: iDerictionHttpService {
    
    var link: String = "https://maps.googleapis.com"
    
    var path: String = "maps/api/directions/json"
    
    var httpMethod: String = "get"
    
    var params: [String : String]?
    
    var HTTPHeaders: [String : String]?
    
    var urlSessionDataTast: URLSessionDataTask?
    
}
