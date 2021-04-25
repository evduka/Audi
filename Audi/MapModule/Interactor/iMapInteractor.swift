//
//  iMapInteractor.swift
//  Audi
//
//  Created by EVGENII DUKA on 12.04.2021.
//

import Foundation
import GoogleMaps

protocol iMapInteractor {
    var delegate: iMapInteractorDelegate? { get set }
    func getCurrentLocation(callBack: @escaping (CLLocation?) -> Void)
    func getPostalAddress(location: CLLocation, onMap map: GMSMapView, callBack: @escaping (String?) -> Void)
    func showLocation(_ location: CLLocation, onMap map: GMSMapView)
    func showLocations(_ locations: [CLLocation], onMap map: GMSMapView)
    func getRoutesFromLocation(_ from: CLLocation, toLocation to: CLLocation, completion: @escaping (Result<[Route], Error>) -> Void)
    func drawRoutes(_ routes: [Route], onMap map: GMSMapView)
    func clearAllRoutes()
}

protocol iMapInteractorDelegate {
    func mapInteractor(_ interactor: iMapInteractor, didTapMap map: GMSMapView, atLocation location: CLLocation)
    func mapInteractor(_ interactor: iMapInteractor, didMoveMap map: GMSMapView, withCurrentCenter centerLocation: CLLocation)
}

