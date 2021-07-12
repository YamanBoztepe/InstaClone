//
//  TabBarController.swift
//  InstaClone
//
//  Created by Yaman Boztepe on 11.07.2021.
//

import UIKit

class TabBarController: UITabBarController {
    private let viewModel = TabBarViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
        setControllers()
        setTabBarLayout()
    }

    private func setControllers() {
        setViewControllers(viewModel.createTabControllers(), animated: true)
    }
    
    private func setTabBarLayout() {
        tabBar.tintColor = .white
        tabBar.barTintColor = .black
        viewModel.setTabBarIcons(for: tabBar)
    }
}

extension TabBarController: UITabBarControllerDelegate {
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        viewModel.setTabBarIcons(for: tabBar)
    }
}
