//
//  Interactor.swift
//  Audi
//
//  Created by EVGENII DUKA on 12.04.2021.
//

import Foundation
import GoogleMaps

class MapInteractor: NSObject {
    
    var locationService: iLocationService?
    
    var mapService: iMapService? {
        didSet {
            if let mapService = self.mapService {
                mapService.delegate = self
            }
        }
    }
    
    var directionHttpService: iDerictionHttpService?
    
    var delegate: iMapInteractorDelegate?
    
    override init() {
        locationService = LocationService()
        directionHttpService = DirectionHttpService()
    }
    
}

//MARK: - iMapInteractor
extension MapInteractor: iMapInteractor {
    
    func getCurrentLocation(callBack: @escaping (CLLocation?) -> Void) {
        guard let locationService = locationService else { return }
        locationService.requestLocation(callBack: callBack)
    }
    
    func showLocation(_ location: CLLocation, onMap map: GMSMapView) {
        if mapService == nil { mapService = MapService(mapView: map) }
        mapService?.showLocation(location)
    }
    
    func showLocations(_ locations: [CLLocation], onMap map: GMSMapView) {
        if mapService == nil { mapService = MapService(mapView: map) }
        mapService?.showLocations(locations)
    }
    
    func getPostalAddress(location: CLLocation, onMap map: GMSMapView, callBack: @escaping (String?) -> Void) {
        if mapService == nil { mapService = MapService(mapView: map) }
        mapService!.getPostalAddress(location: location, callBack: callBack)
    }
    
    func getRoutesFromLocation(_ from: CLLocation, toLocation to: CLLocation, completion: @escaping (Result<[Route], Error>) -> Void) {
        
        guard let directionHttpService = directionHttpService else { return }
        
        directionHttpService.params = ["origin": from.stringValue,
                                       "destination": to.stringValue,
                                       "mode": "walking",
                                       "key": Keys.Google.ApiKey.rawValue]
        
        directionHttpService.startRequest { (result) in
            
            switch result {
            
            case .success(let any):
                
                guard let data = any as? Data else {
                    completion(.failure(NSError()))
                    return
                }
                
                do {
                    
                    let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [String: Any]
                    
                    let routes = json["routes"] as! [[String: Any]]
                    
                    var result: [Route] = []
                    
                    for object in routes {
                        let route = Route(dictionary: object)
                        result.append(route)
                    }
                    
                    completion(.success(result))
                     
                } catch let error {
                    
                    completion(.failure(error))
                    
                }
                
            case .failure(let error):
                
                completion(.failure(error))
                
            }
            
        }
        
    }
    
    func drawRoutes(_ routes: [Route], onMap map: GMSMapView) {
        if mapService == nil { mapService = MapService(mapView: map) }
        let paths = routes.map { $0.overview_polyline?.points }.compactMap { $0 }
        mapService!.drawPaths(paths)
    }
    
    func clearAllRoutes() {
        mapService?.clearAllRoutes()
    }
    
}

//MARK: - iMapServiceDelegate
extension MapInteractor: iMapServiceDelegate {
    
    func mapService(_ service: iMapService, didTapMap map: GMSMapView, atLocation location: CLLocation) {
        guard let delegate = delegate else { return }
        delegate.mapInteractor(self, didTapMap: map, atLocation: location)
    }
    
    func mapService(_ service: iMapService, didMoveMap map: GMSMapView, withCurrentCenter centerLocation: CLLocation) {
        guard let delegate = delegate else { return }
        delegate.mapInteractor(self, didMoveMap: map, withCurrentCenter: centerLocation)
    }
    
}
