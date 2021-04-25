//
//  sdgsdg.swift
//  Audi
//
//  Created by EVGENII DUKA on 13.04.2021.
//

import Foundation

protocol iHttpService: AnyObject {
    var link: String { get }
    var path: String { get }
    var httpMethod: String { get }
    var params: [String : String]? { get set}
    var HTTPHeaders: [String : String]? { get set}
    var urlSessionDataTast: URLSessionDataTask? { get set}
    func startRequest(completion: @escaping (Result<Any, Error>) -> Void)
    func stopCurrentRequest()
}

extension iHttpService {
    
    func createRequest(mainLink: String, path: String, httpMethod: String, params:[String: String]?, headers: [String: String]?) -> URLRequest? {
        
        guard let tempUrl = URL(string: mainLink) else { return nil }
        var url = tempUrl
        url.appendPathComponent(path)
        
        guard let tempComponents = URLComponents(url: url, resolvingAgainstBaseURL: true) else { return nil }
        var components = tempComponents
        if let params = params {
            components.queryItems = params.map({ key, value in
                URLQueryItem(name: key, value: value)
            })
        }
        
        guard let urlFromComponents = components.url else { return nil }
        
        var request = URLRequest(url: urlFromComponents)
        
        request.httpMethod = httpMethod
        
        if let headers = headers {
            for (_, element) in headers.enumerated() {
                request.addValue(element.key, forHTTPHeaderField: element.value)
            }
        }
        
        return request
        
    }
    
    func startRequest(completion: @escaping (Result<Any, Error>) -> Void) {
        
        guard let request = createRequest(mainLink: link, path: path, httpMethod: httpMethod, params: params, headers: HTTPHeaders) else {
            completion(.failure(NSError(domain: "SearchHttpService: URLRequest is nil", code: 0, userInfo: nil)))
            return
        }
        
        print("\(String(describing: request.url?.absoluteString))")
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
            if let error = error {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            } else if let data = data {
                DispatchQueue.main.async {
                    completion(.success(data))
                }
            } else {
                let er = NSError(domain: "CatalogHttp: Data is nil", code: 0, userInfo: nil)
                DispatchQueue.main.async {
                    completion(.failure(er))
                }
            }
            
        }
        
        task.resume()
        urlSessionDataTast = task
        
    }
    
    func stopCurrentRequest() {
        if let task = urlSessionDataTast {
            task.cancel()
        }
    }
    
}
