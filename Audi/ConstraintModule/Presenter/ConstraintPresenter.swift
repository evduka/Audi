//
//  ConstraintPresenter.swift
//  Audi
//
//  Created by EVGENII DUKA on 24.04.2021.
//

import Foundation
import UIKit

class ConstraintPresenter: NSObject {
    
    private var view: iConstraintView
    private var interactor: iConstraintInteractor
    private var addressBottomConstraint: NSLayoutConstraint?
    private var requestRouteHeightConstraint: NSLayoutConstraint?
    private var suggestRouteHeightConstraint: NSLayoutConstraint?
    @objc dynamic var counter = 0
    
    init(view: iConstraintView, interactor: iConstraintInteractor) {
        self.view = view
        self.interactor = interactor
        super.init()
        self.view.presenter = self
        self.view.delegate = self
    }
    
}

//MARK: - iConstraintPresenter
extension ConstraintPresenter: iConstraintPresenter {
    
    func setConstraints(_ constraints: [NSLayoutConstraint]?) {
        addressBottomConstraint = constraints?[0]
        requestRouteHeightConstraint = constraints?[1]
        suggestRouteHeightConstraint = constraints?[2]
    }
    
    func activateRouteState() {
        addressBottomConstraint?.constant = 10
        requestRouteHeightConstraint?.constant = 70
        suggestRouteHeightConstraint?.constant = 70
        counter += 1
    }
    
    func activateNoRouteState() {
        addressBottomConstraint?.constant = 50
        requestRouteHeightConstraint?.constant = 0
        suggestRouteHeightConstraint?.constant = 0
        counter += 1
    }
    
}

//MARK: - iConstraintViewDelegate
extension ConstraintPresenter: iConstraintViewDelegate {
    
}
