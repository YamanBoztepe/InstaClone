//
//  SignUpViewModel.swift
//  InstaClone
//
//  Created by Yaman Boztepe on 21.07.2021.
//

import Foundation

class SignUpViewModel: BaseViewModel {
    private(set) var countries = [Country]()
    private(set) var cities = [CityDetails]()
    
    // MARK: - Validation Actions
    func processSignUp(form: SignUpFormModel) throws {
        if !isFirstNameValid(firstName: form.firstName) {
            throw SignUpError.firstNameIsNotValid("First name characters should be between \(SignUpConstants.firstNameMinLength) and \(SignUpConstants.firstNameMaxLength)")
            
        } else if !isLastNameValid(lastName: form.lastName) {
            throw SignUpError.lastNameIsNotValid("Last name characters should be between \(SignUpConstants.lastNameMinLength) and \(SignUpConstants.lastNameMaxLength)")
            
        } else if !isAddressValid(address: form.address) {
            throw SignUpError.addressIsNotValid("Please select a country and a city")
            
        } else if !isEmailValid(email: form.email) {
            throw SignUpError.emailIsNotValid("Email is not valid")
            
        } else if !isPasswordValid(password: form.password) {
            throw SignUpError.passwordIsNotValid("Password is not valid")
            
        } else if !doPasswordsMatch(password: form.password, repeatPassword: form.repeatPassword) {
            throw SignUpError.passwordsDoNotMatch("Passwords has to be same")
            
        }
        
    }
    
    func isFirstNameValid(firstName: String?) -> Bool {
        guard let firstName = firstName else { return false }
        if firstName.count > SignUpConstants.firstNameMaxLength || firstName.count < SignUpConstants.firstNameMinLength {
            return false
        }
        return true
    }
    
    func isLastNameValid(lastName: String?) -> Bool {
        guard let lastName = lastName else { return false }
        if lastName.count > SignUpConstants.lastNameMaxLength || lastName.count < SignUpConstants.lastNameMinLength {
            return false
        }
        return true
    }
    
    func isEmailValid(email: String?) -> Bool {
        guard let email = email else { return false }
        return NSPredicate(format: "SELF MATCHES %@", "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}").evaluate(with: email)
    }
    
    func isPasswordValid(password: String?) -> Bool {
        guard let password = password else { return false }
        if password.count > SignUpConstants.passwordMaxLength || password.count < SignUpConstants.passwordMinLength {
            return false
        }
        return true
    }
    
    func doPasswordsMatch(password: String?, repeatPassword: String?) -> Bool {
        if let password = password, let repeatPassword = repeatPassword {
            return password == repeatPassword
        }
        return false
    }
    
    func isAddressValid(address: Address) -> Bool {
        address.country != nil && address.city != nil
    }
    
    // MARK: - Country and City actions
    func getCountries() {
        let regionCodes = Locale.isoRegionCodes
        for regionCode in regionCodes {
            let country = Country(countryCode: regionCode, name: Locale.current.localizedString(forRegionCode: regionCode) ?? "")
            countries.append(country)
        }
    }
    
    func getCities(from countryCode: String) {
        let networkManager = NetworkManager.shared
        let url = URLConstants.geoBaseUrl + "\(countryCode)/regions/?limit=10&asciiMode=true"
        
        if let request = networkManager.createUrlRequest(from: url, addValues: [URLConstants.geoApiField : URLConstants.geoApiKey]) {
            
            networkManager.getData(from: request, responseModel: City.self) { [weak self] result in
                guard let self = self else { return }
                
                switch result {
                case .success(let response):
                    self.cities = response.data ?? []
                    self.fetchCompleted?()
                case .failure(let error):
                    print(error)
                    self.errorHandler?(error)
                }
            }
        }
    }
}
