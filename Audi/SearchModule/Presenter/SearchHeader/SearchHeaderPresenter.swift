//
//  SearchHeaderPresenter.swift
//  Audi
//
//  Created by EVGENII DUKA on 19.04.2021.
//

import UIKit

class SearchHeaderPresenter: NSObject {
    
    private var headerView: iSearchHeaderView?
    private var interactor: iSearchInteractor?
    private var originAddressTextField: UITextField?
    private var destinationAddressTextField: UITextField?
    @objc dynamic var places: [Place]?
    @objc dynamic var originPlace: Place?
    @objc dynamic var destinationPlace: Place?
    private var isOriginPlace: Bool = true
    private var timer: Timer?
    
    init(headerView: iSearchHeaderView, interactor: iSearchInteractor) {
        self.headerView = headerView
        self.interactor = interactor
        super.init()
        headerView.presenter = self
        headerView.delegate = self
        interactor.delegate = self
    }
    
    private func didGetPlaces(_ places: [Place]) {
        self.places = places
    }
    
    
    private func setOriginPlace(_ place: Place?) {
        originPlace = place
    }
    
    private func setDestinationPlace(_ place: Place?) {
        destinationPlace = place
    }
    
}

//MARK: - iSearchPresenter
extension SearchHeaderPresenter: iSearchHeaderPresenter {
    
    func setPlace(_ place: Place?) {
        if isOriginPlace {
            setOriginPlace(place)
        }
        else {
            setDestinationPlace(place)
        }
    }
    
    func setPlaces(_ places: [Place?]) {
        switch places.count {
        case 1: setOriginPlace(places[0])
        case 2: setOriginPlace(places[0]); setDestinationPlace(places[1])
        default: return
        }
    }
    
    func setOriginAddressTextField(_ textField: UITextField?) {
        originAddressTextField = textField
        if let textField = textField { textField.delegate = self }
    }
    
    func setDestinationAddressTextField(_ textField: UITextField?) {
        destinationAddressTextField = textField
        if let textField = textField { textField.delegate = self }
    }
    
}

//MARK: - iSearchHeaderViewDelegate
extension SearchHeaderPresenter: iSearchHeaderViewDelegate {
    
    func headerViewWillAppear() {
        isOriginPlace = false
        headerView?.setTextInOriginAddressTextField(text: originPlace?.shortName)
        headerView?.setTextInDestinationAddressTextField(text: destinationPlace?.shortName)
        destinationAddressTextField?.becomeFirstResponder()
    }
    
    func headerViewWillDisappear() {
        isOriginPlace = true
        headerView?.setTextInOriginAddressTextField(text: nil)
        headerView?.setTextInDestinationAddressTextField(text: nil)
        originAddressTextField?.resignFirstResponder()
        destinationAddressTextField?.resignFirstResponder()
    }
    
}

//MARK: - UITextFieldDelegate
extension SearchHeaderPresenter: iSearchInteractorDelegate {
    
    func coordinatesParameter() -> String {
        return "56.85174927,53.28571720"
    }
    
}

//MARK: - UITextFieldDelegate
extension SearchHeaderPresenter: UITextFieldDelegate {
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        (textField == destinationAddressTextField) ? (isOriginPlace = false) : (isOriginPlace = true)
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        timer?.invalidate()
        
        let textSearch = transformText(textField.text ?? "", replacementString: string)
        
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: false, block: { [weak self] _ in
            self?.getPlaces(textSearch: textSearch)
        })
        
        return true
        
    }
    
    private func transformText(_ text: String, replacementString string: String) -> String {
        
        if string == " " && string == "" {
            return text.substring(to: text.count - 1)
        }
        
        return text + string
    }
    
    private func getPlaces(textSearch: String) {
        interactor?.getPlaces(textSearch: textSearch) { [weak self] result in
            switch result {
            case .success(let places): self?.didGetPlaces(places)
            case .failure(let error): print(error)
            }
        }
    }
    
}
