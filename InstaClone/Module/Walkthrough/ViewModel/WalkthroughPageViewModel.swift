//
//  WalkthroughPageViewModel.swift
//  InstaClone
//
//  Created by Yaman Boztepe on 3.07.2021.
//

import UIKit

class WalkthroughPageViewModel: BaseViewModel {
    private(set) var walkthroughs: [WalkthroughContentModel] = [
        WalkthroughContentModel(title: "Find Photos", description: "You can find any type of photo via our app", imageName: "FindPhoto"),
        WalkthroughContentModel(title: "HD Photos", description: "We offer high quality photos", imageName: "HDPhoto"),
        WalkthroughContentModel(title: "Save Favs", description: "You can store your favourite photos in our app", imageName: "HappyUser")
    ]
    
    private(set) var isWalkthroughsEnd = false
    
    func createViewController(at index: Int) -> WalkthroughContentViewController? {
        if index < 0 {
            return nil
        }
        
        let storyboard = UIStoryboard(name: "Walkthrough", bundle: nil)
        guard let pageContentViewController = storyboard.instantiateViewController(identifier: "WalkthroughContentViewController") as? WalkthroughContentViewController else { return nil }
        
        if index < walkthroughs.count {
            pageContentViewController.loadViewIfNeeded()
            pageContentViewController.configure(walkthroughs[index])
            pageContentViewController.index = index
            isWalkthroughsEnd = false
            return pageContentViewController
        } else {
            isWalkthroughsEnd = true
        }
        return nil
    }
}
