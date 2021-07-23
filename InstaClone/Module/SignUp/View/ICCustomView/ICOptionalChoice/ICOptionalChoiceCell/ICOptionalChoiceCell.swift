//
//  ICOptionalChoiceCell.swift
//  InstaClone
//
//  Created by Yaman Boztepe on 18.07.2021.
//

import UIKit

protocol ICOptionalChoiceCellProtocol {
    func btnOptionTapped(numberOfRow: Int)
}

class ICOptionalChoiceCell: UITableViewCell {
    @IBOutlet private weak var lblOptionName: UILabel!
    @IBOutlet private weak var btnOption: UIButton!
    
    static let identifier = "ICOptionalChoiceCell"
    var delegate: ICOptionalChoiceCellProtocol?
    private var numberOfRow: Int?
    var optionSelected = false {
        didSet {
            optionSelected ? btnOption.setImage(UIImage(systemName: "largecircle.fill.circle"), for: .normal) : btnOption.setImage(UIImage(systemName: "circle"), for: .normal)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func configure(with name: String, at numberOfRow: Int) {
        lblOptionName.text = name
        self.numberOfRow = numberOfRow
    }

    @IBAction func btnOptionTapped(_ sender: Any) {
        delegate?.btnOptionTapped(numberOfRow: numberOfRow!)
    }
}
