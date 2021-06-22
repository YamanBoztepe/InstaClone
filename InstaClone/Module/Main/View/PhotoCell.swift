//
//  PhotoCell.swift
//  InstaClone
//
//  Created by Yaman Boztepe on 21.06.2021.
//

import UIKit
import Kingfisher

class PhotoCell: UICollectionViewCell {
    
    static let identifier = "PhotoCell"
    
    private let imgPhoto: UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.contentMode = .scaleToFill
        img.backgroundColor = .systemGray
        return img
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(imgPhoto)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        imgPhoto.image = nil
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        setLayout()
    }
    
    private func setLayout() {
        
        NSLayoutConstraint.activate([
            imgPhoto.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            imgPhoto.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            
            imgPhoto.heightAnchor.constraint(equalTo: heightAnchor)
        ])
    }
    
    func configure(with data: String) {
        let url = URL(string: data)
        imgPhoto.kf.setImage(with: url)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
