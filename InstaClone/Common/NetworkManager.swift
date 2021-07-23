//
//  NetworkManager.swift
//  InstaClone
//
//  Created by Yaman Boztepe on 21.06.2021.
//

import Foundation


class NetworkManager {
    static let shared = NetworkManager()
    
    private init() { }
    
    //MARK: - API Calling
    typealias NetworkResult<U> = (Result<U,Error>) -> Void where U: Decodable
    
    func getData<T: Decodable>(from urlComponents: String, responseModel: T.Type ,
                               completionHandler completion: @escaping NetworkResult<T>) {
        
        guard let url = URL(string: URLConstants.unsplashBaseURL +
                                "\(urlComponents)" +
                                "client_id=\(URLConstants.unsplashApiKey)") else { return }
        print("URL: \(url.absoluteString)")
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else { return }
            
            do {
                let jsonDecoder = JSONDecoder()
                jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
                
                let results = try jsonDecoder.decode(T.self, from: data)
                completion(.success(results))
            } catch {
                completion(.failure(error))
            }
            
        }.resume()
    }
    
    func getData<T: Decodable>(from request: URLRequest, responseModel: T.Type, completionHandler completion: @escaping NetworkResult<T>) {
        print("URL: \(String(describing: request.url))")
        print("Header: \(String(describing: request.allHTTPHeaderFields))")
        
        URLSession.shared.dataTask(with: request) { data, _, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else { return }
            
            do {
                let results = try JSONDecoder().decode(T.self, from: data)
                completion(.success(results))
            } catch {
                completion(.failure(error))
            }
            
        }.resume()
    }
    
    func createUrlRequest(from url: String, addValues headers: [String : String]? = nil) -> URLRequest? {
        guard let url = URL(string: url) else { return nil }
        var urlRequest = URLRequest(url: url)
        
        if headers != nil && headers!.count > 0 {
            for header in headers! {
                urlRequest.addValue(header.value, forHTTPHeaderField: header.key)
            }
        }
        return urlRequest
    }
}



// MARK: - Constants
 struct URLConstants {
    static let unsplashBaseURL = "https://api.unsplash.com/"
    static let unsplashApiKey = "8XfztBX2sC5UobyOlBHhWSB-2OU3xUN0ksIqEfjkXUU"
    
    static let geoBaseUrl = "https://wft-geo-db.p.rapidapi.com/v1/geo/countries/"
    static let geoApiField = "x-rapidapi-key"
    static let geoApiKey = "e25c68381bmsh9e9a9368397689cp156393jsn7c2f32e1eb32"
}
