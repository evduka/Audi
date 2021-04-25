//
//  iMapPresenter.swift
//  Audi
//
//  Created by EVGENII DUKA on 10.04.2021.
//

import Foundation

protocol iMapPresenter {
    var mapView: iMapView? { get }
    var searchHeaderView: iSearchHeaderView { get }
    var searchFooterView: iSearchFooterView { get }
    var constraintView: iConstraintView { get }
    func setOriginAddress(_ address: Address?)
    func setDestinationAddress(_ address: Address?)
    func layoutViewIfNeeded()
}
