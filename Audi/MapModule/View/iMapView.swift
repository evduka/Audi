//
//  iMapView.swift
//  Audi
//
//  Created by EVGENII DUKA on 10.04.2021.
//

import Foundation
import UIKit
import GoogleMaps

protocol iMapView: AnyObject {
    var mapView: GMSMapView! { get set }
    var presenter: iMapPresenter? { get set }
    var delegate: iMapViewDelegate? { get set }
    func setOriginAddress(_ text: String)
    func setDestinationAddress(_ text: String)
    func presentSearchView()
    func dismissSearchView()
    func getOriginAddressTextField() -> UITextField?
    func getDestinationAddressTextField() -> UITextField?
    func getPlacesTableView() -> UITableView?
    func getConstraintsForConstraintModule() -> [NSLayoutConstraint]?
    func activateRouteState()
    func activateNoRouteState()
    func runLayoutIfNeeded()
}

protocol iMapViewDelegate: AnyObject {
    func viewDidLoad(_ view: iMapView)
    func didTapDestinationAddress()
    func didTapBack()
    func didTapCancel()
    func didTapRequestRoute()
}

