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
    func showViewAnimated()
    func hideViewAnimated(completion: (() -> Void)?)
    func dismissFromParent()
}

protocol iRequestCarViewDelegate {
    
    func viewDidLoad()
    func backgroundColoredViewDidTap()
    
}
