//
//  Extensions+UINavigationController.swift
//  InstaClone
//
//  Created by Yaman Boztepe on 4.07.2021.
//

import UIKit

extension UINavigationController {
    
    func pushViewController(viewControllerID: String, in nameOfStoryboard: String, setAsRoot: Bool = false) {
        let storyboard = UIStoryboard(name: nameOfStoryboard, bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: viewControllerID)
        self.pushViewController(vc, animated: false)
        if setAsRoot {
            UIApplication.shared.windows.first?.rootViewController = Self(rootViewController: vc)
        }
        
    }
}
