//
//  Photo.swift
//  InstaClone
//
//  Created by Yaman Boztepe on 21.06.2021.
//

import Foundation

struct Photo: Decodable {
    let total: Int
    let results: [PhotoDetails]
}

struct PhotoDetails: Decodable {
    let createdAt: String
    let urls: ImageUrl
    let likes: Int
    let user: User
}

struct ImageUrl: Decodable {
    let full: String
    let regular: String
}

struct User: Decodable {
    let name: String
    let portfolioUrl: String?
}
