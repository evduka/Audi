//
//  ConstraintView.swift
//  Audi
//
//  Created by EVGENII DUKA on 24.04.2021.
//

import Foundation
import UIKit

class ConstraintView {
    
    var presenter: iConstraintPresenter?
    var delegate: iConstraintViewDelegate?
    private var addressBottomConstraint: NSLayoutConstraint?
    private var requestRouteHeightConstraint: NSLayoutConstraint?
    private var suggestRouteHeightConstraint: NSLayoutConstraint?
    
}

//MARK: - iConstraintView
extension ConstraintView : iConstraintView {
    func setConstraints(_ constraints: [NSLayoutConstraint]?) {
        addressBottomConstraint = constraints?[0]
        requestRouteHeightConstraint = constraints?[1]
        suggestRouteHeightConstraint = constraints?[2]
        guard let presenter = presenter else { return }
        presenter.setConstraints(constraints)
    }
}
