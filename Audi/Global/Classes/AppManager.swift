//
//  PresentersManager.swift
//  Audi
//
//  Created by EVGENII DUKA on 21.04.2021.
//

import Foundation

class AppManager: NSObject {
    
    static let main = AppManager()
    
    @objc dynamic weak var mapPresenter: MapPresenter?
    @objc dynamic weak var searchHeaderPresenter: SearchHeaderPresenter?
    @objc dynamic weak var searchFooterPresenter: SearchFooterPresenter?
    @objc dynamic weak var constraintPresenter: ConstraintPresenter?
    @objc dynamic weak var requestCarPresenter: RequestCarPresenter?
    private var kvo_SearchHeaderPresenter_places: NSKeyValueObservation?
    private var kvo_SearchHeaderPresenter_originPlace: NSKeyValueObservation?
    private var kvo_SearchHeaderPresenter_destinationPlace: NSKeyValueObservation?
    private var kvo_SearchFooterPresenter_selectedPlace: NSKeyValueObservation?
    private var kvo_ConstraintPresenter_counter: NSKeyValueObservation?
    
    override init() {
        super.init()
        
        let mapView = MapViewController.initFromStoryboardWithTheSameName()
        let headerView = SearchHeaderView()
        let footerView = SearchFooterView()
        let constraintView = ConstraintView()
        
        let interactor = MapInteractor()
        let searchInteractor = SearchInteractor()
        let searchFooterInteractor = SearchFooterInteractor()
        let constraintInteractor = ConstraintInteractor()
        
        let searchHeaderPresenter = SearchHeaderPresenter(headerView: headerView, interactor: searchInteractor)
        let searchFooterPresenter = SearchFooterPresenter(footerView: footerView, interactor: searchFooterInteractor)
        let constraintPresenter = ConstraintPresenter(view: constraintView, interactor: constraintInteractor)
        let mapPresenter = MapPresenter(mapView: mapView, searchHeaderView: headerView, searchFooterView: footerView, constraintView: constraintView, interactor: interactor)
        
        self.mapPresenter = mapPresenter
        self.searchHeaderPresenter = searchHeaderPresenter
        self.searchFooterPresenter = searchFooterPresenter
        self.constraintPresenter = constraintPresenter
        
        create_kvo_SearchHeaderPresenter_places()
        create_kvo_SearchHeaderPresenter_originPlace()
        create_kvo_SearchHeaderPresenter_destinationPlace()
        create_kvo_SearchFooterPresenter_selectedPlace()
        create_kvo_constraintPresenter_counter()
        
    }
    
}

//MARK: - Builder
extension AppManager {
    
    func buildMapViewController() -> MapViewController? {
        return mapPresenter?.mapView as? MapViewController
    }
    
    func buildRequestCarViewController() -> RequestCarViewController? {
        let requestCarView = RequestCarViewController.initFromStoryboardWithTheSameName()
        let requestCarInteractor = RequestCarInteractor()
        let requestCarPresenter = RequestCarPresenter(view: requestCarView, interactor: requestCarInteractor)
        self.requestCarPresenter = requestCarPresenter
        return requestCarView
    }
    
}

//MARK: - KVO
extension AppManager {
    
    private func create_kvo_SearchHeaderPresenter_places() {
        guard let _ = searchHeaderPresenter else { return }
        kvo_SearchHeaderPresenter_places = observe(\AppManager.searchHeaderPresenter?.places, options: [.new], changeHandler: { [weak self] sender, change in
            guard let places = change.newValue as? [Place] else { return }
            self?.searchFooterPresenter?.setPlaces(places)
        })
    }
    
    private func create_kvo_SearchHeaderPresenter_originPlace() {
        guard let _ = searchHeaderPresenter else { return }
        kvo_SearchHeaderPresenter_originPlace = observe(\AppManager.searchHeaderPresenter?.originPlace, options: [.new], changeHandler: { [weak self] sender, change in
            guard let place = change.newValue as? Place else { return }
            guard let address = Address(place: place) else { return }
            self?.mapPresenter?.setOriginAddress(address)
        })
    }
    
    private func create_kvo_SearchHeaderPresenter_destinationPlace() {
        guard let _ = searchHeaderPresenter else { return }
        kvo_SearchHeaderPresenter_destinationPlace = observe(\AppManager.searchHeaderPresenter?.destinationPlace, options: [.new], changeHandler: { [weak self] sender, change in
            guard let place = change.newValue as? Place else { return }
            guard let address = Address(place: place) else { return }
            self?.mapPresenter?.setDestinationAddress(address)
        })
    }
    
    private func create_kvo_SearchFooterPresenter_selectedPlace() {
        guard let _ = searchFooterPresenter else { return }
        kvo_SearchFooterPresenter_selectedPlace = observe(\AppManager.searchFooterPresenter?.selectedPlace, options: [.new]) { [weak self] sender, change in
            guard let place = change.newValue as? Place else { return }
            self?.searchHeaderPresenter?.setPlace(place)
        }
    }
    
    private func create_kvo_constraintPresenter_counter() {
        guard let _ = constraintPresenter else { return }
        guard let _ = mapPresenter else { return }
        kvo_ConstraintPresenter_counter = observe(\AppManager.constraintPresenter?.counter, options: [.new]) { [weak self] sender, change in
            self?.mapPresenter?.layoutViewIfNeeded()
        }
    }
    
}
