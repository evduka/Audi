//
//  iMapService.swift
//  Audi
//
//  Created by EVGENII DUKA on 12.04.2021.
//

import Foundation
import GoogleMaps

protocol iMapService: GMSMapViewDelegate {
    var delegate: iMapServiceDelegate? { get set }
    func showLocation(_ location: CLLocation)
    func showLocations(_ locations: [CLLocation])
    func getPostalAddress(location: CLLocation, callBack: @escaping (String?) -> Void)
    func drawPaths(_ points: [String])
    func clearAllRoutes()
}

protocol iMapServiceDelegate {
    func mapService(_ service: iMapService, didTapMap map: GMSMapView, atLocation location: CLLocation)
    func mapService(_ service: iMapService, didMoveMap map: GMSMapView, withCurrentCenter centerLocation: CLLocation)
}

