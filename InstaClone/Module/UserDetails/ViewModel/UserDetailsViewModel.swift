//
//  UserDetailsViewModel.swift
//  InstaClone
//
//  Created by Yaman Boztepe on 15.07.2021.
//

import Foundation

class UserDetailsViewModel: BaseViewModel {
    private(set) var response: UserDetails?
    private(set) var socialMedias = [SocialMediaDetails]()
    
    func fetchDetails(for user: String) {
        NetworkManager.shared.getData(from: "users/\(user)?", responseModel: UserDetails.self) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let response):
                self.response = response
                self.addSocialMedias(from: response)
                self.fetchCompleted?()
                
            case .failure(let error):
                self.errorHandler?(error)
            }
        }
    }
    
    private func addSocialMedias(from response: UserDetails) {
        [SocialMediaDetails(socialMediaDescription: response.instagramUsername, socialMediaIconName: "instagramLogo"),
         SocialMediaDetails(socialMediaDescription: response.twitterUsername, socialMediaIconName: "twitter"),
         SocialMediaDetails(socialMediaDescription: response.portfolioUrl, socialMediaIconName: "link")
        ]
        .forEach { socialMedias.append($0) }
        cleanData()
    }
    
    private func cleanData() {
        socialMedias.removeAll { $0.socialMediaDescription == nil || $0.socialMediaDescription == "" }
    }
}
