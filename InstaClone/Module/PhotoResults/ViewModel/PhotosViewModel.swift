//
//  PhotoResultsViewModel.swift
//  InstaClone
//
//  Created by Yaman Boztepe on 22.06.2021.
//

import UIKit

class PhotosViewModel: BaseViewModel {
    private(set) var fetchStatus: PhotoFetchStatus = .idle
    private(set) var photoURLs = [String]()
    private(set) var photoInfos = [PhotoDetails]()
    private(set) var photosFinished = false
    private var page = 1
    var textToSearch: String? {
        didSet {
            fetchPhotos(from: textToSearch!)
        }
    }
    
    // Fetch Photo for specific search
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
    
    // Fetch Random Photo
    func fetchPhotos() {
        if fetchStatus != .fetching {
            let urlComponents = "photos?page=\(page)&"
            fetchStatus = .fetching
            page += 1
            
            NetworkManager.shared.getData(from: urlComponents, responseModel: [PhotoDetails].self) { [weak self] result in
                guard let self = self else { return }
                
                switch result {
                case .success(let response):
                    self.photoURLs.append(contentsOf: response.compactMap { $0.urls.regular })
                    self.photoInfos.append(contentsOf: response)
                    
                    self.fetchCompleted?()
                    self.fetchStatus = .idle
                    
                case .failure(let error):
                    self.errorHandler?(error)
                    self.fetchStatus = .idle
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

