//
//  iRequestCarView.swift
//  Audi
//
//  Created by EVGENII DUKA on 25.04.2021.
//

import Foundation

protocol iRequestCarView: AnyObject {
    var presenter: iRequestCarPresenter? { set get }
    var delegate: iRequestCarViewDelegate? { set get }
}

protocol iRequestCarViewDelegate {
    
}
