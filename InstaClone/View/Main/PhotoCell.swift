//
//  PhotoCell.swift
//  InstaClone
//
//  Created by Yaman Boztepe on 21.06.2021.
//

import UIKit

class PhotoCell: UICollectionViewCell {
    
    static let identifier = "PhotoCell"
    
    private let imgPhoto: UIImageView = {
        let img = UIImageView()
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
        imgPhoto.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imgPhoto.centerYAnchor.constraint(equalTo: centerYAnchor),
            imgPhoto.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            imgPhoto.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.9),
            imgPhoto.heightAnchor.constraint(equalTo: heightAnchor)
        ])
    }
    
    func configure(with image: UIImage) {
        self.imgPhoto.image = image
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
