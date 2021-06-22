//
//  MainViewModel.swift
//  InstaClone
//
//  Created by Yaman Boztepe on 22.06.2021.
//

import UIKit

class MainViewModel {

    private(set) var fetchStatus: PhotoFetchStatus = .idle
    
    
    func fetchPhotos(page: Int = 1 , completion: @escaping ([UIImage]) -> Void) {

        var photos = [UIImage]()
        fetchStatus = .fetching
        NetworkManager.shared.fetchData(numberOfPage: page) { (result) in
            switch result {

            case .success(let response):

                let photoURLs = response.compactMap { $0.urls.regular }

                for photoString in photoURLs {
                    guard let photoURL = URL(string: photoString), let data = try? Data(contentsOf: photoURL) else { continue }
                    if let photo = UIImage(data: data) {
                        photos.append(photo)
                    }
                }
                self.fetchStatus = .idle
                completion(photos)

            case .failure(let error):
                print(error)
                self.fetchStatus = .idle
            }
        }
        

    }
    
    enum PhotoFetchStatus {
        case idle
        case fetching
    }
    
}

