//
//  RequestCarPresenter.swift
//  Audi
//
//  Created by EVGENII DUKA on 25.04.2021.
//

import Foundation

class RequestCarPresenter: NSObject {
    
    private weak var view: iRequestCarView?
    private var interactor: iRequestCarInteractor?
    
    init(view: iRequestCarView, interactor: iRequestCarInteractor) {
        self.view = view
        self.interactor = interactor
        super.init()
        view.presenter = self
        view.delegate = self
    }
    
}

//MARK: - iRequestCarPresenter
extension RequestCarPresenter: iRequestCarPresenter {
    
}

//MARK: - iRequestCarViewDelegate
extension RequestCarPresenter: iRequestCarViewDelegate {
    
}
