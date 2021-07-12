//
//  WalkthroughPageViewController.swift
//  InstaClone
//
//  Created by Yaman Boztepe on 3.07.2021.
//

import UIKit

class WalkthroughPageViewController: UIPageViewController {

    let viewModel = WalkthroughPageViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setDelegates()
        startWalkthrough()
    }
    
    private func setDelegates() {
        let scrollView = view.subviews.filter { $0 is UIScrollView }.first as! UIScrollView
        scrollView.delegate = self
        
        dataSource = self
    }
    
    private func startWalkthrough() {
        if let firstViewController = viewModel.createViewController(at: 0) {
            setViewControllers([firstViewController], direction: .forward, animated: true)
        }
    }
}

// MARK: - PageViewController
extension WalkthroughPageViewController: UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let vc = viewController as? WalkthroughContentViewController else { return UIViewController () }
        
        var currentIndex = vc.index
        currentIndex -= 1
        return viewModel.createViewController(at: currentIndex)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let vc = viewController as? WalkthroughContentViewController else { return UIViewController () }
        
        var currentIndex = vc.index
        currentIndex += 1
        return viewModel.createViewController(at: currentIndex)
    }
    
}

// MARK: - ScrollView
extension WalkthroughPageViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if viewModel.isWalkthroughsEnd && scrollView.contentOffset.x > view.frame.maxX {
            UserDefaults.standard.setValue(true, forKey: "didWalkthroughAppear")
            navigationController?.pushViewController(TabBarController(), setAsRoot: true)
        }
    }
}
