//
//  iSearchFooterPresenter.swift
//  Audi
//
//  Created by EVGENII DUKA on 21.04.2021.
//

import Foundation
import UIKit

protocol iSearchFooterPresenter: AnyObject, UITableViewDataSource, UITableViewDelegate {
    func setPlaces(_ places: [Place])
    func setPlacesTableView(_ tableView: UITableView?)
}
