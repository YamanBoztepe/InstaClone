//
//  BaseViewModel.swift
//  InstaClone
//
//  Created by Yaman Boztepe on 2.07.2021.
//

import Foundation

class BaseViewModel {
    var errorHandler: ((Error) -> Void)?
    var fetchCompleted: (() -> Void)?
}
