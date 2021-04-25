//
//  MapPresenter.swift
//  Audi
//
//  Created by EVGENII DUKA on 10.04.2021.
//

import Foundation
import GoogleMaps

enum MapPresenterStare {
    case noRoute, Route
}

class MapPresenter: NSObject {
    
//    private var tappedLocation: [CLLocation] = [] {
//
//        didSet {
//            if let path = pathes.first, let location = self.tappedLocation.last {
//                var coordinate = CLLocationCoordinate2D(latitude: 1.0, longitude: 1.0)
//                var at: UInt = 0
//                while coordinate.latitude > 0 && coordinate.longitude > 0 {
//                    coordinate = path.coordinate(at: at)
//                    let distance = location.distance(from: CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude))
//                    print("\(distance)")
//                    at += 3
//                }
//            }
//        }
//
//    }
    
    private var pathes: [GMSPath] = []
    private var routes: [Route] = []
    @objc dynamic var originAddress: Address?
    private var destinationAddress: Address?
    weak var mapView: iMapView?
    var searchHeaderView: iSearchHeaderView
    var searchFooterView: iSearchFooterView
    var constraintView: iConstraintView
    private var interactor: iMapInteractor
    
    private var state: MapPresenterStare = .noRoute {
        willSet {
            switch newValue {
            case .Route:
                mapView?.activateRouteState()
                constraintView.presenter?.activateRouteState()
                guard let originAddress = originAddress else { return }
                guard let destinationAddress = destinationAddress else { return }
                drawRouteFrom(originAddress, to: destinationAddress)
            case .noRoute:
                destinationAddress = nil
                interactor.clearAllRoutes()
                mapView?.activateNoRouteState()
                constraintView.presenter?.activateNoRouteState()
                guard let originAddress = originAddress else { return }
                showAddress(originAddress)
            }
        }
    }
    
    init(mapView: iMapView, searchHeaderView: iSearchHeaderView, searchFooterView: iSearchFooterView, constraintView: iConstraintView, interactor: iMapInteractor) {
        self.mapView = mapView
        self.searchHeaderView = searchHeaderView
        self.searchFooterView = searchFooterView
        self.constraintView = constraintView
        self.interactor = interactor
        super.init()
        self.interactor.delegate = self
        mapView.presenter = self
        mapView.delegate = self
    }
    
    private func didSetAddress() {
        setTextInAddressLabelsOfView()
        Settings.main.originAddress = originAddress
        Settings.main.destinationAddress = destinationAddress
    }
    
    private func setupSearchHeaderView() {
        let originTextField = self.mapView?.getOriginAddressTextField()
        let destinationTextField = self.mapView?.getDestinationAddressTextField()
        searchHeaderView.passTextFieldsToPresenter([originTextField, destinationTextField])
    }
    
    private func setupSearchFooterView() {
        let placesTableView = self.mapView?.getPlacesTableView()
        searchFooterView.passPlacesTableViewToPresenter(placesTableView)
    }
    
    private func setupConstraintView() {
        guard let constraints = self.mapView?.getConstraintsForConstraintModule() else { return }
        constraintView.setConstraints(constraints)
    }
    
    private func setTextInAddressLabelsOfView() {
        mapView?.setOriginAddress(originAddress?.shortName ?? "")
        mapView?.setDestinationAddress(destinationAddress?.shortName ?? "")
    }
    
    private func extractAddressFromDefaults() {
        originAddress = Settings.main.originAddress
        destinationAddress = Settings.main.destinationAddress
    }
    
}

//MARK: - iMapPresenter
extension MapPresenter: iMapPresenter {
    
    func setOriginAddress(_ address: Address?) {
        self.originAddress = address
        didSetAddress()
        changeStateIfNeeded()
        if destinationAddress != nil { dismissSearchViews() }
    }
    
    func setDestinationAddress(_ address: Address?) {
        self.destinationAddress = address
        didSetAddress()
        changeStateIfNeeded()
        if originAddress != nil { dismissSearchViews() }
    }
    
    func layoutViewIfNeeded() {
        mapView?.runLayoutIfNeeded()
    }
    
}

//MARK: - iMapViewDelegate
extension MapPresenter: iMapViewDelegate {

    func viewDidLoad(_ view: iMapView) {
        setupSearchHeaderView()
        setupSearchFooterView()
        setupConstraintView()
        extractAddressFromDefaults()
        didSetAddress()
        getCurrentAddress()
    }
    
    func didTapDestinationAddress() {
        searchHeaderView.passAddressToPresenter([originAddress, destinationAddress])
        searchHeaderView.willAppear()
        searchFooterView.willAppear()
        self.mapView?.presentSearchView()
    }
    
    func didTapBack() {
        dismissSearchViews()
    }
    
    func didTapCancel() {
        state = .noRoute
    }
    
    func didTapRequestRoute() {
        guard let requestViewController = AppManager.main.buildRequestCarViewController() else { return }
        self.mapView?.showViewController(requestViewController)
    }
    
}

//MARK: - iMapInteractorDelegate
extension MapPresenter: iMapInteractorDelegate {
    
    func mapInteractor(_ interactor: iMapInteractor, didTapMap map: GMSMapView, atLocation location: CLLocation) {
        
//        tappedLocation.append(location)
//
//        let currentIndex = 0
//        let nextIndex = 1
//
//        while nextIndex < tappedLocation.count {
//
//            let origin = tappedLocation[currentIndex]
//            let destination = tappedLocation[nextIndex]
//
//            tappedLocation.removeAll()
//
//            interactor.getRoutesFromLocation(origin, toLocation: destination) { [weak self] result in
//
//                switch result {
//                case .success(let routes):
//                    self?.routes = routes
//                    guard let map = self?.mapView?.mapView else { return }
//                    self?.interactor.drawRoutes(routes, onMap: map)
//                case .failure(let error):
//                    print(error)
//                }
//
//            }
//
//        }
        
    }
    
    func mapInteractor(_ interactor: iMapInteractor, didMoveMap map: GMSMapView, withCurrentCenter centerLocation: CLLocation) {
        guard state == .noRoute else { return }
        interactor.getPostalAddress(location: centerLocation, onMap: map) { [weak self] response in
            guard let response = response else { return }
            self?.originAddress = Address(name: response, location: centerLocation)
            self?.didSetAddress()
        }
    }
    
}

//MARK: - Helpers
extension MapPresenter {
    
    private func getCurrentAddress() {
        interactor.getCurrentLocation { [weak self] location in
            guard let location = location else { return }
            guard let map = self?.mapView?.mapView else { return }
            self?.interactor.getPostalAddress(location: location, onMap: map) { [weak self] response in
                guard let response = response else { return }
                let incomeAddress = Address(name: response, location: location)
                self?.originAddress = incomeAddress
                self?.showAddress(incomeAddress)
                self?.didSetAddress()
            }
        }
    }
    
    private func drawRouteFrom(_ address1: Address, to address2: Address) {
        guard let map = self.mapView?.mapView else { return }
        interactor.getRoutesFromLocation(address1.location, toLocation: address2.location) { [weak self] result in
            switch result {
            case .success(let routes):
                self?.interactor.drawRoutes(routes, onMap: map)
                self?.interactor.showLocations([address1.location, address2.location], onMap: map)
            case .failure(let error): print(error)
            }
        }
    }
    
    private func showAddress(_ address: Address) {
        guard let map = self.mapView?.mapView else { return }
        interactor.showLocation(address.location, onMap: map)
    }
    
    private func dismissSearchViews() {
        searchHeaderView.willDisappear()
        searchFooterView.willDisappear()
        self.mapView?.dismissSearchView()
    }
    
    private func changeStateIfNeeded() {
        if originAddress != nil, destinationAddress != nil { state = .Route } else { state = .noRoute }
    }
    
}

