//
//  UserDetailCell.swift
//  InstaClone
//
//  Created by Yaman Boztepe on 15.07.2021.
//

import UIKit

class UserDetailCell: UITableViewCell {
    static let identifier = "UserDetailCell"

    @IBOutlet weak var imgIcon: UIImageView!
    @IBOutlet weak var lblIconDescription: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func configure(with socialMediaDetails: SocialMediaDetails) {
        lblIconDescription.text = socialMediaDetails.socialMediaDescription
        imgIcon.image = UIImage(named: socialMediaDetails.socialMediaIconName)
    }
}
