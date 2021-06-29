//
//  BaseController.swift
//  InstaClone
//
//  Created by Yaman Boztepe on 27.06.2021.
//

import UIKit


class BaseController: UIViewController {
    
    var spinner: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if spinner == nil {
            spinner = UIActivityIndicatorView()
            spinner.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(spinner)
            spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
            spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        }
    }
    
    // MARK: - Loading Indicator Actions
    func startLoading() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            if !self.spinner.isAnimating {
                self.spinner.startAnimating()
                self.view.isUserInteractionEnabled = false
            }
        }
    }
    func stopLoading() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.spinner.stopAnimating()
            self.view.isUserInteractionEnabled = true
        }
    }
    
}
