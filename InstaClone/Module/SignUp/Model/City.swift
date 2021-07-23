//
//  CityDetails.swift
//  InstaClone
//
//  Created by Yaman Boztepe on 22.07.2021.
//

import Foundation

struct City: Decodable {
    let data: [CityDetails]?
}

struct CityDetails: Decodable {
    let countryCode: String?
    let name: String?
}
