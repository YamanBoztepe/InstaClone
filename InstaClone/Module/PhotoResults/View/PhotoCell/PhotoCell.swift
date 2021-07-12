//
//  PhotoCell.swift
//  InstaClone
//
//  Created by Yaman Boztepe on 28.06.2021.
//

import UIKit
import Kingfisher

protocol PhotoCellDelegate {
    func cellPressed(numberOfRow: Int)
}

class PhotoCell: UICollectionViewCell {
    @IBOutlet var imgPhoto: UIImageView!
    
    private var numberOfRow = 0
    static let identifier = "PhotoCell"
    var delegate: PhotoCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    func configure(with urlString: String, at numberOfRow: Int) {
        guard let url = URL(string: urlString) else { return }
        imgPhoto.kf.setImage(with: url)
        self.numberOfRow = numberOfRow
    }
    
    @IBAction func cellPressed(_ sender: UIButton) {
        delegate?.cellPressed(numberOfRow: numberOfRow)
    }
    
}
