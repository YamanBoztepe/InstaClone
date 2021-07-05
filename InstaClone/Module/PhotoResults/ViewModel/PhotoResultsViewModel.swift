//
//  PhotoResultsViewModel.swift
//  InstaClone
//
//  Created by Yaman Boztepe on 22.06.2021.
//

import UIKit

class PhotoResultsViewModel: BaseViewModel {
    private(set) var fetchStatus: PhotoFetchStatus = .idle
    private(set) var photoURLs = [String]()
    private(set) var photosFinished = false
    private var page = 1
    var textToSearch: String? {
        didSet {
            fetchPhotos(from: textToSearch!)
        }
    }
    
    
    private func fetchPhotos(from text: String) {
        if fetchStatus != .fetching {
            let urlComponents = "search/photos/?page=\(page)&query=\(text)&"
            fetchStatus = .fetching
            page += 1
            
            if !photosFinished {
                NetworkManager.shared.getData(from: urlComponents, responseModel: Photo.self) { [weak self] result in
                    guard let self = self else { return }
                    
                    switch result {
                    case .success(let response):
                        self.photoURLs.append(contentsOf: response.results.compactMap { $0.urls.regular })
                        
                        self.photosFinished = response.total == self.photoURLs.count
                        self.fetchCompleted?()
                        self.fetchStatus = .idle
                        
                    case .failure(let error):
                        self.errorHandler?(error)
                        self.fetchStatus = .idle
                    }
                }
            }
        }
    }
    
    func removeAllPhotos() {
        photoURLs = []
    }
    
    
    enum PhotoFetchStatus {
        case idle
        case fetching
    }
    
}

