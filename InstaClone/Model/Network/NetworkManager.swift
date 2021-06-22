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
    
    func fetchData(numberOfPage: Int = 1, completionHandler completion: @escaping (Result<[UnsplashAPIModel],Error>) -> Void) {
        guard let url = URL(string: URLConstants.baseURL +
                                "?page=\(numberOfPage)" +
                                "&client_id=\(URLConstants.apiKey)") else { return }
        
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            if let data = data {
                do {
                    let jsonDecoder = JSONDecoder()
                    jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
                    
                    let results = try jsonDecoder.decode([UnsplashAPIModel].self, from: data)
                    completion(.success(results))
                } catch {
                    completion(.failure(error))
                }
            }
            
        }.resume()
    }
}



// MARK: - Constants
private struct URLConstants {
    static let baseURL = "https://api.unsplash.com/photos/"
    static let apiKey = "8XfztBX2sC5UobyOlBHhWSB-2OU3xUN0ksIqEfjkXUU"
    
}
