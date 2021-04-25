//
//  LocationService.swift
//  Audi
//
//  Created by EVGENII DUKA on 12.04.2021.
//

import Foundation
import CoreLocation

class LocationService: NSObject {
    
    private let locationManager = CLLocationManager()
    private var  didReceiveLocation: ((CLLocation?) -> Void)?
    
    override init() {
        super.init()
        locationManager.delegate = self
    }
    
}

//MARK: - iLocationService
extension LocationService: iLocationService {
    
    func requestLocation(callBack: @escaping (CLLocation?) -> Void) {
        
        self.didReceiveLocation = callBack
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.requestLocation()
        } else {
            locationManager.requestWhenInUseAuthorization()
        }
        
    }
    
    func distanceFrom(_ origin: CLLocation, to destination: CLLocation) -> Double {
        return origin.distance(from: destination)
    }
    
}

//MARK: - CLLocationManagerDelegate
extension LocationService: CLLocationManagerDelegate {
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        guard manager.authorizationStatus == .authorizedWhenInUse else { return }
        manager.requestLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let callBack = didReceiveLocation, let location = locations.first else { return }
        callBack(location)
        didReceiveLocation = nil
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    
}
