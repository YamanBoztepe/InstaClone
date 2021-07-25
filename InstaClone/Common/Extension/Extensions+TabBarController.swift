//
//  Extensions+TabBarController.swift
//  InstaClone
//
//  Created by Yaman Boztepe on 24.07.2021.
//

import UIKit

extension TabBarController {
    
    func handleDeepLink(_ deepLink: DeepLink) {
        switch deepLink {
        case .search:
            changeTab(indexPath: 0)
        case .random:
            changeTab(indexPath: 1)
        case .signup:
            changeTab(indexPath: 2)
        }
    }
}
