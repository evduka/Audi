//
//  MapService.swift
//  Audi
//
//  Created by EVGENII DUKA on 12.04.2021.
//

import Foundation
import GoogleMaps

class MapService: NSObject {
    
    private var waypoints: [GMSMarker] = []
    private var currentPolyline: GMSPolyline?
    private var mapView: GMSMapView
    var delegate: iMapServiceDelegate?
    
    init(mapView: GMSMapView) {
        self.mapView = mapView
        super.init()
        mapView.delegate = self
        mapView.isMyLocationEnabled = true
        mapView.settings.myLocationButton = true
    }
    
    private func getCurrentCenter() -> CLLocation {
        let point = mapView.center
        let coor = mapView.projection.coordinate(for: point)
        return CLLocation(latitude: coor.latitude, longitude: coor.longitude)
    }
    
}

//MARK: - iMapService
extension MapService: iMapService {
    
    func showLocation(_ location: CLLocation) {
        mapView.animate(to: GMSCameraPosition(target: location.coordinate, zoom: 17, bearing: 0, viewingAngle: 0))
    }
    
    func showLocations(_ locations: [CLLocation]) {
        guard locations.count > 1 else { return }
        let c1 = locations[0].coordinate
        var c2 = locations[1].coordinate
        c2.latitude -= 0.01
        let bounds = GMSCoordinateBounds(coordinate: c1, coordinate: c2)
        let update = GMSCameraUpdate.fit(bounds, withPadding: 150.0)
        mapView.animate(with: update)
    }
    
    func getPostalAddress(location: CLLocation, callBack: @escaping (String?) -> Void) {
        
        GMSGeocoder().reverseGeocodeCoordinate(location.coordinate) { response, error in
            guard let address = response?.firstResult(), let lines = address.lines else {
                callBack(nil)
                return
            }
            callBack(lines.joined(separator: "\n"))
        }
        
    }
    
    func drawPaths(_ points: [String]) {
        currentPolyline?.map = nil
        guard let point = points.first else { return }
        guard let path = GMSPath(fromEncodedPath: point) else { return }
        let polyline = GMSPolyline(path: path)
        polyline.strokeColor = UIColor.random()
        polyline.strokeWidth = 5
        polyline.map = mapView
        currentPolyline = polyline
    }
    
    func clearAllRoutes() {
        currentPolyline?.map = nil
    }
    
}

//MARK: - GMSMapViewDelegate
extension MapService: GMSMapViewDelegate {
    
    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
        
        let marker = GMSMarker(position: coordinate)
        waypoints.append(marker)
        
        guard let delegate = delegate else { return }
        let location = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
        delegate.mapService(self, didTapMap: mapView, atLocation: location)
        
    }
    
    func mapView(_ mapView: GMSMapView, idleAt position: GMSCameraPosition) {
        guard let delegate = delegate else { return }
        let currentCenter = getCurrentCenter()
        delegate.mapService(self, didMoveMap: mapView, withCurrentCenter: currentCenter)
    }
    
}
