//
//  PhotoDetailsController.swift
//  InstaClone
//
//  Created by Yaman Boztepe on 12.07.2021.
//

import UIKit

class PhotoDetailsController: UIViewController {
    @IBOutlet weak var imgPhotoDetail: UIImageView!
    @IBOutlet weak var lblNameOfPhotoOwner: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        hideOwnerName()
        addGesture()
    }
    
    private func hideOwnerName() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            UIView.animate(withDuration: 1) { [weak self] in
                guard let self = self else { return }
                self.lblNameOfPhotoOwner.alpha = 0
            }
        }
    }
    
    private func addGesture() {
        let imgTapGesture = UITapGestureRecognizer(target: self, action: #selector(imgPhotoDetailPressed))
        imgPhotoDetail.addGestureRecognizer(imgTapGesture)
    }
    
    @IBAction func btnBackPressed(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    
    @objc private func imgPhotoDetailPressed() {
        lblNameOfPhotoOwner.alpha = 0.3
        hideOwnerName()
    }

}
