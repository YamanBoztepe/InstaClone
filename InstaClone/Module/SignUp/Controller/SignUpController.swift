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
    @IBOutlet weak var txtRepeatPassword: ICTextField!
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
        setDelegates()
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
        txtRepeatPassword.setTitle("Repeat Password*")
        txtRepeatPassword.enableSecureText()
        txtPhoneNumber.setTitle("Phone Number")
        txtPhoneNumber.setKeyboardType(.phonePad)
        genderChoiceField.setTitle("Gender")
        genderChoiceField.addOptions(["Male", "Female", "Others"])
    }
    
    private func setDelegates() {
        addressSelectionField.txtCity.delegate = self
        addressSelectionField.txtCountry.delegate = self
        
        btnSignUp.delegate = self
    }
    
    private func setupPickerView() {
        countryPickerView.delegate = self
        countryPickerView.dataSource = self
        
        cityPickerView.delegate = self
        cityPickerView.dataSource = self
        
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
    
    private func hideErrors() {
        [txtUserName, txtUserSurname, txtUserEmail, txtPassword, txtRepeatPassword].forEach { $0.hideError() }
        addressSelectionField.hideError()
    }
    
    private func showFakeSuccessPopup() {
        startLoading()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [weak self] in
            guard let self = self else { return }
            
            let alert = UIAlertController(title: "Completed", message: "You have successfully registered", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Okey", style: .default, handler: { _ in
                self.stopLoading()
            }))
            self.present(alert, animated: true)
        }
    }
}

// MARK: - PickerView
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

// MARK: - ICButton
extension SignUpController: ICButtonProtocol {
        
    func ICButtonTapped() {
        hideErrors()
        
        let signUpForm = SignUpFormModel(firstName: txtUserName.userInput,
                                         lastName: txtUserSurname.userInput,
                                         email: txtUserEmail.userInput,
                                         password: txtPassword.userInput,
                                         repeatPassword: txtRepeatPassword.userInput,
                                         address: Address(country: addressSelectionField.selectedCountry,
                                                          city: addressSelectionField.selectedCity))
        do {
            try viewModel.processSignUp(form: signUpForm)
            showFakeSuccessPopup()
            
        } catch SignUpError.firstNameIsNotValid(let error) {
            txtUserName.showError(message: error)
            
        } catch SignUpError.lastNameIsNotValid(let error) {
            txtUserSurname.showError(message: error)
            
        } catch SignUpError.emailIsNotValid(let error) {
            txtUserEmail.showError(message: error)
            
        } catch SignUpError.passwordIsNotValid(let error) {
            txtPassword.showError(message: error)
            
        } catch SignUpError.passwordsDoNotMatch(let error) {
            txtPassword.showError(message: error)
            txtRepeatPassword.showError(message: error)
            
        } catch SignUpError.addressIsNotValid(let error) {
            addressSelectionField.showError(message: error)
            
        } catch {
            print(error)
        }
    }
}
