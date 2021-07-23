//
//  ICTextField.swift
//  InstaClone
//
//  Created by Yaman Boztepe on 18.07.2021.
//

import UIKit

class ICTextField: UIView {
    @IBOutlet private weak var lblTitle: UILabel!
    @IBOutlet private weak var lblError: UILabel!
    @IBOutlet private weak var txtUserInput: UITextField!
    
    @IBOutlet weak var textFieldBottomConstraint: NSLayoutConstraint!
    
    
    private(set) var userInput: String?
    private var isMandatory = false
    
    override func awakeFromNib() {
        createNibView(nibName: "ICTextField")
        textFieldBottomConstraint.constant = 0
        txtUserInput.delegate = self
    }
    
    // MARK: - Layout
    func setTitle(_ title: String) {
        lblTitle.text = title
    }
    
    func showError(message: String) {
        lblError.text = message
        textFieldBottomConstraint.constant = 30
    }
    
    func hideError() {
        textFieldBottomConstraint.constant = 0
    }
    
    func enableSecureText() {
        txtUserInput.textContentType = .oneTimeCode
        txtUserInput.isSecureTextEntry = true
    }
    
    func setKeyboardType(_ keyboardType: UIKeyboardType) {
        txtUserInput.keyboardType = keyboardType
    }
    
    // MARK: - Actions
    func setAsMandatory() {
        isMandatory = true
    }
}

extension ICTextField: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        userInput = textField.text
    }
}
