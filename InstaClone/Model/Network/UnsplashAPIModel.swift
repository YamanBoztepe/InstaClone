//
//  UnsplashAPIModel.swift
//  InstaClone
//
//  Created by Yaman Boztepe on 21.06.2021.
//

import Foundation

struct UnsplashAPIModel: Decodable {
    let createdAt: String
    let urls: ImageUrls
    let likes: Int
    let user: User
}

struct ImageUrls: Decodable {
    let full: String
    let regular: String
}

struct User: Decodable {
    let name: String
    let portfolioUrl: String?
}
