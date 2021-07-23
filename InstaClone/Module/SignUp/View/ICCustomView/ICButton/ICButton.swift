//
//  ICButton.swift
//  InstaClone
//
//  Created by Yaman Boztepe on 23.07.2021.
//

import UIKit

protocol ICButtonProtocol {
    func ICButtonTapped()
}

class ICButton: UIView {
    @IBOutlet private weak var btnSignUp: UIButton!
    
    var delegate: ICButtonProtocol?

    override func awakeFromNib() {
        super.awakeFromNib()
        createNibView(nibName: "ICButton")
        setLayout()
    }
    
    // MARK: - Layout
    private func setLayout() {
        btnSignUp.layer.cornerRadius = 10
        
        btnSignUp.layer.shadowColor = UIColor.black.cgColor
        btnSignUp.layer.shadowRadius = 10
        btnSignUp.layer.shadowOffset = .init(width: 15, height: 15)
        btnSignUp.layer.shadowOpacity = 1
    }
    
    // MARK: - Actions
    @IBAction func btnSignUpTapped(_ sender: Any) {
        delegate?.ICButtonTapped()
    }
}
