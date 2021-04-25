//
//  SearchFooterView.swift
//  Audi
//
//  Created by EVGENII DUKA on 21.04.2021.
//

import Foundation
import UIKit

class SearchFooterView {
    
    private var addressTableView: UITableView?
    
    var presenter: iSearchFooterPresenter?
    var delegate: iSearchFooterViewDelegate?
    
}

extension SearchFooterView: iSearchFooterView {
   
    func passPlacesTableViewToPresenter(_ tableView: UITableView?) {
        addressTableView = tableView
        guard let presenter = presenter else { return }
        presenter.setPlacesTableView(tableView)
    }
    
    func willAppear() {
        guard let delegate = delegate else { return }
        delegate.footerViewWillAppear()
    }
    
    func willDisappear() {
        guard let delegate = delegate else { return }
        delegate.footerViewWillDisappear()
    }
    
}
