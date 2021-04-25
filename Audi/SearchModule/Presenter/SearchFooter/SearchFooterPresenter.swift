//
//  SearchFooterPresenter.swift
//  Audi
//
//  Created by EVGENII DUKA on 21.04.2021.
//

import Foundation
import UIKit

class SearchFooterPresenter: NSObject {
    
    private var footerView: iSearchFooterView?
    private var interactor: iSearchFooterInteractor?
    private var addressTableView: UITableView?
    private var places: [Place]?
    @objc dynamic var selectedPlace: Place?
    
    init(footerView: iSearchFooterView, interactor: iSearchFooterInteractor) {
        self.footerView = footerView
        self.interactor = interactor
        super.init()
        footerView.presenter = self
        footerView.delegate = self
        interactor.delegate = self
    }
    
    func reloadTableView() {
        if let table = addressTableView { table.reloadData() }
    }
    
}

//MARK: - iSearchFooterPresenter
extension SearchFooterPresenter: iSearchFooterPresenter {
    
    func setPlaces(_ places: [Place]) {
        self.places = places
        reloadTableView()
    }
    
    func setPlacesTableView(_ tableView: UITableView?) {
        addressTableView = tableView
        guard let tableView = tableView else { return }
        tableView.dataSource = self
        tableView.delegate = self
    }
    
}

//MARK: - iSearchHeaderViewDelegate
extension SearchFooterPresenter: iSearchFooterViewDelegate {
    
    func footerViewWillAppear() {
        reloadTableView()
    }
    
    func footerViewWillDisappear() {
        places = nil
    }
    
}

//MARK: - UITextFieldDelegate
extension SearchFooterPresenter: iSearchFooterInteractorDelegate {
    
}

//MARK: - UITableViewDataSource
extension SearchFooterPresenter: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return places?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell") {
            
            cell.textLabel?.text = createAbsoluteString(places![indexPath.row])
            return cell
            
        } else {
            
            let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
            cell.selectionStyle = .none
            cell.textLabel?.numberOfLines = 0
            cell.textLabel?.text = createAbsoluteString(places![indexPath.row])
            return cell
            
        }
        
    }
    
    private func createAbsoluteString(_ place: Place) -> String {
        return place.formatted_address ?? "there is no address"
    }
    
}

//MARK: - UITableViewDelegate
extension SearchFooterPresenter: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let places = places, indexPath.row < places.count else { return }
        self.selectedPlace = places[indexPath.row]   
    }
    
}
