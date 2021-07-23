//
//  SignUpController.swift
//  InstaClone
//
//  Created by Yaman Boztepe on 15.07.2021.
//

import UIKit

class SignUpController: BaseController {
    @IBOutlet private weak var txtUserName: ICTextField!
    @IBOutlet weak var txtUserSurname: ICTextField!
    @IBOutlet weak var txtUserEmail: ICTextField!
    @IBOutlet weak var txtPassword: ICTextField!
    @IBOutlet weak var txtPhoneNumber: ICTextField!
    @IBOutlet weak var genderChoiceField: ICOptionalChoice!
    @IBOutlet weak var birthDateField: ICBirthDate!
    @IBOutlet weak var addressSelectionField: ICSelection!
    @IBOutlet weak var btnSignUp: ICButton!
    
    
    private let viewModel = SignUpViewModel()
    private let countryPickerView = UIPickerView()
    private let cityPickerView = UIPickerView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLayout()
        view.dismissKeyboardWhenViewTapped()
        viewModel.getCountries()
        setupPickerView()
        updateUI()
    }
    
    // MARK: - Layout
    private func setLayout() {
        txtUserName.setTitle("Name*")
        txtUserSurname.setTitle("Surname*")
        txtUserEmail.setTitle("Email Address*")
        txtPassword.setTitle("Password*")
        txtPassword.enableSecureText()
        txtPhoneNumber.setTitle("Phone Number")
        txtPhoneNumber.setKeyboardType(.phonePad)
        genderChoiceField.setTitle("Gender")
        genderChoiceField.addOptions(["Male", "Female", "Others"])
        
        addressSelectionField.txtCity.delegate = self
        addressSelectionField.txtCountry.delegate = self
    }
    
    private func setupPickerView() {
        [countryPickerView, cityPickerView].forEach { [weak self] picker in
            guard let self = self else { return }
            picker.delegate = self
            picker.dataSource = self
        }
        
        addressSelectionField.txtCountry.inputView = countryPickerView
        addressSelectionField.txtCity.inputView = cityPickerView
    }
    
    private func updateUI() {
        viewModel.fetchCompleted = { [weak self] in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.countryPickerView.reloadInputViews()
                self.cityPickerView.reloadInputViews()
                self.stopLoading()
            }
        }
    }
}

extension SignUpController: UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == countryPickerView {
            return viewModel.countries.count
        } else {
            return viewModel.cities.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == countryPickerView {
            return viewModel.countries[row].name
        } else {
            return viewModel.cities[row].name
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == countryPickerView {
            addressSelectionField.setCountry(viewModel.countries[row].name)
            viewModel.getCities(from: viewModel.countries[row].countryCode)
            addressSelectionField.setCity(nil)
            startLoading()
        } else {
            addressSelectionField.setCity(viewModel.cities[row].name)
        }
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == addressSelectionField.txtCity {
            if viewModel.cities.count == 0 {
                addressSelectionField.showError(message: "Please select a country first")
                return false
            }
        } else if textField == addressSelectionField.txtCountry {
            addressSelectionField.hideError()
        }
        return true
    }
}
