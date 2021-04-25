//
//  iConstraintView.swift
//  Audi
//
//  Created by EVGENII DUKA on 24.04.2021.
//

import Foundation
import UIKit

protocol iConstraintView {
    var presenter: iConstraintPresenter? { set get }
    var delegate: iConstraintViewDelegate? { set get }
    func setConstraints(_ constraints: [NSLayoutConstraint]?)
}

protocol iConstraintViewDelegate {
    
}
