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
        
        guard let url = URL(string: URLConstants.baseURL +
                                "\(urlComponents)" +
                                "client_id=\(URLConstants.apiKey)") else { return }
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
}



// MARK: - Constants
private struct URLConstants {
    static let baseURL = "https://api.unsplash.com/"
    static let apiKey = "8XfztBX2sC5UobyOlBHhWSB-2OU3xUN0ksIqEfjkXUU"
    
}
