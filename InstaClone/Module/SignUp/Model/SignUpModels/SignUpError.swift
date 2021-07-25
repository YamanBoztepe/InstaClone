//
//  SignUpError.swift
//  InstaClone
//
//  Created by Yaman Boztepe on 23.07.2021.
//

import Foundation

enum SignUpError: Error {
    case firstNameIsNotValid(String)
    case lastNameIsNotValid(String)
    case emailIsNotValid(String)
    case passwordIsNotValid(String)
    case passwordsDoNotMatch(String)
    case addressIsNotValid(String)
}
