//
//  SearchInteractor.swift
//  Audi
//
//  Created by EVGENII DUKA on 20.04.2021.
//

import Foundation

class SearchInteractor {
    
    weak var delegate: iSearchInteractorDelegate?
    var placeHttpService: iPlaceHttpService?
    
    init() {
        placeHttpService = PlaceHttpService()
    }
    
}

//MARK: - iSearchInteractor
extension SearchInteractor: iSearchInteractor {
    
    func getPlaces(textSearch: String, completion: @escaping (Result<[Place], Error>) -> Void) {
        
        guard let placeHttpService = placeHttpService else { return }
        
        placeHttpService.params = ["query": textSearch,
                                   "key": Keys.Google.ApiKey.rawValue]
        
        if let delegate = delegate {
            placeHttpService.params?["location"] = delegate.coordinatesParameter()
            placeHttpService.params?["radius"] = "20000"
        }
        
        placeHttpService.startRequest { (result) in
            
            switch result {
            
            case .success(let any):
                
                guard let data = any as? Data else {
                    completion(.failure(NSError()))
                    return
                }
                
                do {
                    
                    let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [String: Any]
                    
                    let results = json["results"] as! [[String: Any]]
                    
                    var result: [Place] = []
                    
                    for object in results {
                        let place = Place(dictionary: object)
                        result.append(place)
                    }
                    
                    completion(.success(result))
                     
                } catch let error {
                    
                    completion(.failure(error))
                    
                }
                
            case .failure(let error):
                
                completion(.failure(error))
                
            }
            
        }
        
    }
    
}
