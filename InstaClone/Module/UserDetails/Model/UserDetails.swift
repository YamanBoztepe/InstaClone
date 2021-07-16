//
//  UserDetails.swift
//  InstaClone
//
//  Created by Yaman Boztepe on 15.07.2021.
//

import Foundation

struct UserDetails: Decodable {
    let name: String
    let twitterUsername: String?
    let instagramUsername: String?
    let portfolioUrl: String?
    let totalLikes: Int?
    let totalPhotos: Int?
    let profileImage: ProfileImage
}

struct ProfileImage: Decodable {
    let medium: String?
}
