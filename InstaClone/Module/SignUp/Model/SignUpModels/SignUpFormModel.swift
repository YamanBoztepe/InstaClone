//
//  SignUpFormModel.swift
//  InstaClone
//
//  Created by Yaman Boztepe on 23.07.2021.
//

import Foundation

struct SignUpFormModel {
    let firstName: String?
    let lastName: String?
    let email: String?
    let password: String?
    let repeatPassword: String?
    let address: Address
}

struct Address: Codable {
    let country: String?
    let city: String?
}
