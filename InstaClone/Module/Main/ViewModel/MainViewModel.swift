//
//  MainViewModel.swift
//  InstaClone
//
//  Created by Yaman Boztepe on 22.06.2021.
//

import UIKit

class MainViewModel {
    private(set) var fetchStatus: PhotoFetchStatus = .idle {
        didSet {
            if fetchStatus == .fetching {
                page += 1
            }
        }
    }
    private(set) var photoURLs = [String]()
    private var page = 0
    var photosFetched: (() -> Void)?
    
    func fetchPhotos() {
        let urlComponents = "photos/?page=\(page)&"
        fetchStatus = .fetching
        
        NetworkManager.shared.getData(from: urlComponents, responseModel: Array<Photo>.self) { result in
            switch result {
            case .success(let response):
                self.photoURLs.append(contentsOf: response.compactMap { $0.urls.regular })

                self.photosFetched?()
                self.fetchStatus = .idle
                
            case .failure(let error):
                print(error)
                self.fetchStatus = .idle
            }
        }
    }
    
    func fetchMorePhotosIfPossible() {
        if fetchStatus != .fetching {
            fetchPhotos()
        }
    }
    
    enum PhotoFetchStatus {
        case idle
        case fetching
    }
    
}

