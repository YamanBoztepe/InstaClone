//
//  FooterCell.swift
//  InstaClone
//
//  Created by Yaman Boztepe on 30.06.2021.
//

import UIKit

class FooterCell: UICollectionViewCell {
    @IBOutlet var spinner: UIActivityIndicatorView!
    @IBOutlet var lblPhotosFinished: UILabel!
    
    static let identifier = "FooterCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func configure(with model: PhotoResultsViewModel) {
        if model.photosFinished {
            spinner.stopAnimating()
            lblPhotosFinished.isHidden = false
        }
    }

}
