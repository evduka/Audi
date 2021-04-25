//
//  MapViewController.swift
//  Audi
//
//  Created by EVGENII DUKA on 10.04.2021.
//

import UIKit
import GoogleMaps

class MapViewController: UIViewController {
    
    @IBOutlet weak var mapView: GMSMapView!
    @IBOutlet weak var pinView: UIView!
    @IBOutlet weak var originAddressLabel: UILabel!
    @IBOutlet weak var destinationAddressLabel: UILabel!
    @IBOutlet weak var originAddressTextField: UITextField!
    @IBOutlet weak var destinationAddressTextField: UITextField!
    @IBOutlet weak var searchHeaderView: UIView!
    @IBOutlet weak var searchFooterView: UIView!
    @IBOutlet weak var addressTableView: UITableView!
    @IBOutlet weak var requestRouteButton: UIButton!
    @IBOutlet weak var suggestRouteButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    
    @IBOutlet weak var addressBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var requestRouteHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var suggestRouteHeightConstraint: NSLayoutConstraint!
    
    var presenter: iMapPresenter?
    var delegate: iMapViewDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Settings.main.destinationAddress = nil
        
        if let delegate = delegate {
            delegate.viewDidLoad(self)
        }
        
    }
    
    private func setIsHidden(_ isHidden: Bool, forViews views: [UIView]) {
        views.forEach { $0.isHidden = isHidden }
    }
    
}

//MARK: - iMapView
extension MapViewController: iMapView {
    
    func setOriginAddress(_ text: String) {
        let suffix = "From:"
        originAddressLabel.text = suffix + " " + text
    }
    
    func setDestinationAddress(_ text: String) {
        let suffix = text.count > 0 ? "To:" : "Where to:"
        destinationAddressLabel.text = suffix + " " + text
    }
    
    func presentSearchView() {
        setIsHidden(false, forViews: [searchHeaderView, searchFooterView])
    }
    
    func dismissSearchView() {
        setIsHidden(true, forViews: [searchHeaderView, searchFooterView])
    }
    
    func getOriginAddressTextField() -> UITextField? {
        return originAddressTextField
    }
    
    func getDestinationAddressTextField() -> UITextField? {
        return destinationAddressTextField
    }
    
    func getPlacesTableView() -> UITableView? {
        return addressTableView
    }
    
    func getConstraintsForConstraintModule() -> [NSLayoutConstraint]? {
        return [addressBottomConstraint, requestRouteHeightConstraint, suggestRouteHeightConstraint]
    }
    
    
    func activateRouteState() {
        pinView.isHidden = true
        cancelButton.isHidden = false
        requestRouteButton.isHidden = false
        suggestRouteButton.isHidden = false
    }
    
    func activateNoRouteState() {
        pinView.isHidden = false
        cancelButton.isHidden = true
        requestRouteButton.isHidden = true
        suggestRouteButton.isHidden = true
    }
    
    func runLayoutIfNeeded() {
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
    
}

//MARK: - IBActions
extension MapViewController {
    
    @IBAction func destinationAddressAction(_ sender: Any) {
        guard let delegate = delegate else { return }
        delegate.didTapDestinationAddress()
    }
    
    @IBAction func destinationAddressBackAction(_ sender: Any) {
        guard let delegate = delegate else { return }
        delegate.didTapBack()
    }
    
    @IBAction func requestRouteButtonAction(_ sender: Any) {
        
    }
    
    @IBAction func suggestRouteButtonAction(_ sender: Any) {
        
    }
    
    @IBAction func cancelButtonAction(_ sender: Any) {
        guard let delegate = delegate else { return }
        delegate.didTapCancel()
    }
    
}
