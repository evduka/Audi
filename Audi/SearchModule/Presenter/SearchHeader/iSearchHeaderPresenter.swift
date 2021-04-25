//
//  iSearchHeaderPresenter.swift
//  Audi
//
//  Created by EVGENII DUKA on 19.04.2021.
//

import UIKit

protocol iSearchHeaderPresenter: AnyObject, UITextFieldDelegate {
    func setPlace(_ place: Place?)
    func setPlaces(_ places: [Place?])
    func setOriginAddressTextField(_ textField: UITextField?)
    func setDestinationAddressTextField(_ textField: UITextField?)
}
