//
//  iSearchInteractor.swift
//  Audi
//
//  Created by EVGENII DUKA on 20.04.2021.
//

import Foundation

protocol iSearchInteractor: AnyObject {
    var delegate: iSearchInteractorDelegate? { set get }
    func getPlaces(textSearch: String, completion: @escaping (Result<[Place], Error>) -> Void)
}

protocol iSearchInteractorDelegate: AnyObject {
    func coordinatesParameter() -> String
}
