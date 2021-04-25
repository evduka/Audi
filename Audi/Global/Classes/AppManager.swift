//
//  PresentersManager.swift
//  Audi
//
//  Created by EVGENII DUKA on 21.04.2021.
//

import Foundation

class AppManager: NSObject {
    
    static let main = AppManager()
    
    @objc dynamic var mapPresenter: MapPresenter?
    @objc dynamic var searchHeaderPresenter: SearchHeaderPresenter?
    @objc dynamic var searchFooterPresenter: SearchFooterPresenter?
    @objc dynamic var constraintPresenter: ConstraintPresenter?
    var kvo_SearchHeaderPresenter_places: NSKeyValueObservation?
    var kvo_SearchHeaderPresenter_originPlace: NSKeyValueObservation?
    var kvo_SearchHeaderPresenter_destinationPlace: NSKeyValueObservation?
    var kvo_SearchFooterPresenter_selectedPlace: NSKeyValueObservation?
    var kvo_ConstraintPresenter_counter: NSKeyValueObservation?
    
    func create_kvo_SearchHeaderPresenter_places() {
        guard let _ = searchHeaderPresenter else { return }
        kvo_SearchHeaderPresenter_places = observe(\AppManager.searchHeaderPresenter?.places, options: [.new], changeHandler: { [weak self] sender, change in
            guard let places = change.newValue as? [Place] else { return }
            self?.searchFooterPresenter?.setPlaces(places)
        })
    }
    
    func create_kvo_SearchHeaderPresenter_originPlace() {
        guard let _ = searchHeaderPresenter else { return }
        kvo_SearchHeaderPresenter_originPlace = observe(\AppManager.searchHeaderPresenter?.originPlace, options: [.new], changeHandler: { [weak self] sender, change in
            guard let place = change.newValue as? Place else { return }
            guard let address = Address(place: place) else { return }
            self?.mapPresenter?.setOriginAddress(address)
        })
    }
    
    func create_kvo_SearchHeaderPresenter_destinationPlace() {
        guard let _ = searchHeaderPresenter else { return }
        kvo_SearchHeaderPresenter_destinationPlace = observe(\AppManager.searchHeaderPresenter?.destinationPlace, options: [.new], changeHandler: { [weak self] sender, change in
            guard let place = change.newValue as? Place else { return }
            guard let address = Address(place: place) else { return }
            self?.mapPresenter?.setDestinationAddress(address)
        })
    }
    
    func create_kvo_SearchFooterPresenter_selectedPlace() {
        guard let _ = searchFooterPresenter else { return }
        kvo_SearchFooterPresenter_selectedPlace = observe(\AppManager.searchFooterPresenter?.selectedPlace, options: [.new]) { [weak self] sender, change in
            guard let place = change.newValue as? Place else { return }
            self?.searchHeaderPresenter?.setPlace(place)
        }
    }
    
    func create_kvo_constraintPresenter_counter() {
        guard let _ = constraintPresenter else { return }
        guard let _ = mapPresenter else { return }
        kvo_ConstraintPresenter_counter = observe(\AppManager.constraintPresenter?.counter, options: [.new]) { [weak self] sender, change in
            self?.mapPresenter?.layoutViewIfNeeded()
        }
    }
    
    
}
