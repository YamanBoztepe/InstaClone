//
//  SearchTextError.swift
//  InstaClone
//
//  Created by Yaman Boztepe on 2.07.2021.
//

import Foundation

enum SearchTextError: String, Error {
    case NilText = "You should write something for searching images"
    case InvalidText = "You should enter valid characters for searching images"
}
