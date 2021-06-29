//
//  PhotoCell.swift
//  InstaClone
//
//  Created by Yaman Boztepe on 28.06.2021.
//

import UIKit
import Kingfisher

class PhotoCell: UICollectionViewCell {
    @IBOutlet var imgPhoto: UIImageView!
    
    static let identifier = "PhotoCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    func configure(with urlString: String) {
        guard let url = URL(string: urlString) else { return }
        imgPhoto.kf.setImage(with: url)
    }
    
}
