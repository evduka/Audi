//
//  iSearchHeaderView.swift
//  Audi
//
//  Created by EVGENII DUKA on 19.04.2021.
//

import UIKit

protocol iSearchHeaderView: AnyObject {
    var presenter: iSearchHeaderPresenter? { set get }
    var delegate: iSearchHeaderViewDelegate? { set get }
    func passAddressToPresenter(_ address: [Address?])
    func passTextFieldsToPresenter(_ textFields: [UITextField?])
    func setTextInOriginAddressTextField(text: String?)
    func setTextInDestinationAddressTextField(text: String?)
    func willAppear()
    func willDisappear()
}

protocol iSearchHeaderViewDelegate {
    func headerViewWillAppear()
    func headerViewWillDisappear()
}
