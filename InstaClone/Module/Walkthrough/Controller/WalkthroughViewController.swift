//
//  WalkthroughViewController.swift
//  InstaClone
//
//  Created by Yaman Boztepe on 3.07.2021.
//

import UIKit

class WalkthroughViewController: UIViewController {
    @IBOutlet weak var btnSkip: UIButton!
    @IBOutlet weak var pageControl: UIPageControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? WalkthroughPageViewController {
            pageControl.numberOfPages = vc.viewModel.walkthroughs.count
            vc.delegate = self
        }
    }
    
    @IBAction func skipButtonPressed(_ sender: Any) {
        UserDefaults.standard.setValue(true, forKey: "didWalkthroughAppear")
        navigationController?.pushViewController(TabBarController(), setAsRoot: true)
    }
    
}

// MARK: - PageViewDelegate
extension WalkthroughViewController: UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, willTransitionTo pendingViewControllers: [UIViewController]) {
        guard let vc = pendingViewControllers.first as? WalkthroughContentViewController else { return }
        pageControl.currentPage = vc.index
    }
}
