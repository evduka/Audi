//
//  sdgs.swift
//  Audi
//
//  Created by EVGENII DUKA on 19.04.2021.
//

import UIKit

class SearchHeaderView: NSObject {
    
    private var originAddressTextField: UITextField?
    private var destinationAddressTextField: UITextField?
    var presenter: iSearchHeaderPresenter?
    var delegate: iSearchHeaderViewDelegate?
    
}

//MARK: - iSearchHeaderView
extension SearchHeaderView: iSearchHeaderView {
    
    func passAddressToPresenter(_ address: [Address?]) {
        guard let presenter = presenter else { return }
        var origin: Place?
        var destination: Place?
        switch address.count {
        case 1:
            if let address = address[0] { origin = Place(address: address) }
        case 2:
            if let address = address[0] { origin = Place(address: address) }
            if let address = address[1] { destination = Place(address: address) }
        default: return
        }
        presenter.setPlaces([origin, destination])
    }
    
    func passTextFieldsToPresenter(_ textFields: [UITextField?]) {
        switch textFields.count {
        case 1:
            originAddressTextField = textFields[0]
            guard let presenter = presenter else { return }
            presenter.setOriginAddressTextField(textFields[0])
        case 2:
            originAddressTextField = textFields[0]
            destinationAddressTextField = textFields[1]
            guard let presenter = presenter else { return }
            presenter.setOriginAddressTextField(textFields[0])
            presenter.setDestinationAddressTextField(textFields[1])
        default: return
        }
    }
    
    func setTextInOriginAddressTextField(text: String?) {
        originAddressTextField?.text = text
    }

    func setTextInDestinationAddressTextField(text: String?) {
        destinationAddressTextField?.text = text
    }
    
    func willAppear() {
        guard let delegate = delegate else { return }
        delegate.headerViewWillAppear()
    }
    
    func willDisappear() {
        guard let delegate = delegate else { return }
        delegate.headerViewWillDisappear()
    }
    
}

//MARK: - Helpers
extension SearchHeaderView {
    
    
    
}



