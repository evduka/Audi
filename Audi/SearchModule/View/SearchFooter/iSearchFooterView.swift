//
//  verrer.swift
//  Audi
//
//  Created by EVGENII DUKA on 21.04.2021.
//

import Foundation
import UIKit

protocol iSearchFooterView: AnyObject {
    var presenter: iSearchFooterPresenter? { set get }
    var delegate: iSearchFooterViewDelegate? { set get }
    func passPlacesTableViewToPresenter(_ tableView: UITableView?)
    func willAppear()
    func willDisappear()
}

protocol iSearchFooterViewDelegate {
    func footerViewWillAppear()
    func footerViewWillDisappear()
}
