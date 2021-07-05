//
//  WalkthroughContentViewController.swift
//  InstaClone
//
//  Created by Yaman Boztepe on 3.07.2021.
//

import UIKit

class WalkthroughContentViewController: UIViewController {
    @IBOutlet weak var imgWalkthrough: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    
    var index = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    // MARK: - Layout
    func configure(_ model: WalkthroughContentModel) {
        lblTitle.text = model.title
        lblDescription.text = model.description
        if let imageName = model.imageName, let image = UIImage(named: imageName)?.withRenderingMode(.alwaysOriginal) {
            imgWalkthrough.image = image
        }
    }
}
