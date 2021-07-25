//
//  ICSelection.swift
//  InstaClone
//
//  Created by Yaman Boztepe on 21.07.2021.
//

import UIKit

class ICSelection: UIView {
    @IBOutlet private weak var lblAddress: UILabel!
    @IBOutlet private weak var lblError: UILabel!
    @IBOutlet weak var txtCountry: UITextField!
    @IBOutlet weak var txtCity: UITextField!
    
    @IBOutlet weak var stackViewBottomConstraint: NSLayoutConstraint!
    
    
    private(set) var selectedCountry: String? {
        didSet {
            txtCountry.text = selectedCountry
        }
    }
    
    private(set) var selectedCity: String? {
        didSet {
            txtCity.text = selectedCity
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        createNibView(nibName: "ICSelection")
        stackViewBottomConstraint.constant = 0
    }
    
    // MARK: - Actions
    func setCountry(_ country: String?) {
        selectedCountry = country
    }
    
    func setCity(_ city: String?) {
        selectedCity = city
    }
    
    func showError(message: String) {
        lblError.text = message
        stackViewBottomConstraint.constant = 30
    }
    
    func hideError() {
        stackViewBottomConstraint.constant = 0
    }
    
}
