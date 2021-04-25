//
//  iConstraintPresenter.swift
//  Audi
//
//  Created by EVGENII DUKA on 24.04.2021.
//

import Foundation
import UIKit

protocol iConstraintPresenter {
    func activateRouteState()
    func activateNoRouteState()
    func setConstraints(_ constraints: [NSLayoutConstraint]?)
}
