//
//  TabBarViewModel.swift
//  InstaClone
//
//  Created by Yaman Boztepe on 11.07.2021.
//

import UIKit

class TabBarViewModel {
    
    private(set) var tabControllers = [
        OrganizedControllersModel(storyboardID: "SearchPhotos",
                                  viewControllerID: "SearchPhotosController",
                                  title: "Search"),
        OrganizedControllersModel(storyboardID: "RandomPhotos",
                                  viewControllerID: "RandomPhotosController",
                                  title: "Random Photos")
    ]
    
    // MARK: - Create ViewControllers
    func createTabControllers() -> [UIViewController] {
        var tabViewControllers = [UIViewController]()
        
        for i in 0...tabControllers.count - 1 {
            let storyboard = UIStoryboard(name: tabControllers[i].storyboardID, bundle: nil)
            let vc = storyboard.instantiateViewController(identifier: tabControllers[i].viewControllerID)
            vc.title = tabControllers[i].title
            tabViewControllers.append(vc)
        }
        
        return tabViewControllers
    }
    
    // MARK: - Set Icons
    func setTabBarIcons(for tabBar: UITabBar) {
        guard let items = tabBar.items else { return }
        
        for item in items {
            if item == tabBar.selectedItem {
                item.image = UIImage(systemName: "largecircle.fill.circle")
            } else {
                item.image = UIImage(systemName: "circle")
            }
        }
    }
}
