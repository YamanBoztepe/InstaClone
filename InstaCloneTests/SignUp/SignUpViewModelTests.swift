//
//  SignUpViewModelTests.swift
//  InstaCloneTests
//
//  Created by Yaman Boztepe on 25.07.2021.
//

import XCTest
@testable import InstaClone

class SignUpViewModelTests: XCTestCase {
    var sut: SignUpViewModel!

    override func setUp() {
        sut = SignUpViewModel()
    }

    override func tearDown() {
        sut = nil
    }
    
    // MARK: - First Name Tests
    func testSignUpViewModel_whenValidFirstNameProvided_shouldReturnTrue() {
        // When
        let isFirstNameValid = sut.isFirstNameValid(firstName: "test")
        
        // Then
        XCTAssertTrue(isFirstNameValid, "Expected 'True' statement when valid first name is provided, but it returns 'False' statement. Probably given first name's length is bigger than \(SignUpConstants.firstNameMaxLength) or smaller than \(SignUpConstants.firstNameMinLength)")
    }
    
    func testSignUpViewModel_whenShortFirstNameProvided_shouldReturnFalse() {
        // When
        let isFirstNameValid = sut.isFirstNameValid(firstName: "t")
        
        // Then
        XCTAssertFalse(isFirstNameValid, "Expected 'False' statement when invalid first name is provided, but it returns 'True' statement. Probably given first name's length is smaller than \(SignUpConstants.firstNameMaxLength) or bigger than \(SignUpConstants.firstNameMinLength)")
    }
    
    func testSignUpViewModel_whenLongFirstNameProvided_shouldReturnFalse() {
        // When
        let isFirstNameValid = sut.isFirstNameValid(firstName: "testTestTest")
        
        // Then
        XCTAssertFalse(isFirstNameValid, "Expected 'False' statement when invalid first name is provided, but it returns 'True' statement. Probably given first name's length is smaller than \(SignUpConstants.firstNameMaxLength) or bigger than \(SignUpConstants.firstNameMinLength)")
    }
    
    func testSignUpViewModel_whenFirstNameNotProvided_shouldReturnFalse() {
        // When
        let isFirstNameValid = sut.isFirstNameValid(firstName: nil)
        
        // Then
        XCTAssertFalse(isFirstNameValid, "Expected 'False' statement when first name is not provided, but it returns 'True' statement.")
    }
    
    // MARK: - Last Name Tests
    func testSignUpViewModel_whenValidLastNameProvided_shouldReturnTrue() {
        // When
        let isLastNameValid = sut.isLastNameValid(lastName: "test")
        
        // Then
        XCTAssertTrue(isLastNameValid, "Expected 'True' statement when valid last name is provided, but it returns 'False' statement. Probably given last name's length is bigger than \(SignUpConstants.lastNameMaxLength) or smaller than \(SignUpConstants.lastNameMinLength)")
    }
    
    func testSignUpViewModel_whenShortLastNameProvided_shouldReturnFalse() {
        // When
        let isLastNameValid = sut.isLastNameValid(lastName: "t")
        
        // Then
        XCTAssertFalse(isLastNameValid, "Expected 'False' statement when invalid last name is provided, but it returns 'True' statement. Probably given last name's length is smaller than \(SignUpConstants.lastNameMaxLength) or bigger than \(SignUpConstants.lastNameMinLength)")
    }
    
    func testSignUpViewModel_whenLongLastNameProvided_shouldReturnFalse() {
        // When
        let isLastNameValid = sut.isLastNameValid(lastName: "testTestTestTest")
        
        // Then
        XCTAssertFalse(isLastNameValid, "Expected 'False' statement when invalid last name is provided, but it returns 'True' statement. Probably given last name's length is smaller than \(SignUpConstants.lastNameMaxLength) or bigger than \(SignUpConstants.lastNameMinLength)")
    }
    
    func testSignUpViewModel_whenLastNameNotProvided_shouldReturnFalse() {
        // When
        let isLastNameValid = sut.isLastNameValid(lastName: nil)
        
        // Then
        XCTAssertFalse(isLastNameValid, "Expected 'False' statement when last name is not provided, but it returns 'True' statement.")
    }
    
    // MARK: - Password Tests
    func testSignUpViewModel_whenValidPasswordProvided_shouldReturnTrue() {
        // When
        let isPasswordValid = sut.isPasswordValid(password: "123456789")
        
        // Then
        XCTAssertTrue(isPasswordValid, "Expected 'True' statement when valid password is provided, but it returns 'False' statement. Probably given password's length is bigger than \(SignUpConstants.passwordMaxLength) or smaller than \(SignUpConstants.passwordMinLength)")
    }
    
    func testSignUpViewModel_whenShortPasswordProvided_shouldReturnFalse() {
        // When
        let isPasswordValid = sut.isPasswordValid(password: "1234")
        
        // Then
        XCTAssertFalse(isPasswordValid, "Expected 'False' statement when invalid password is provided, but it returns 'True' statement. Probably given password's length is smaller than \(SignUpConstants.passwordMaxLength) or bigger than \(SignUpConstants.passwordMinLength)")
    }
    
    func testSignUpViewModel_whenLongPasswordProvided_shouldReturnFalse() {
        // When
        let isPasswordValid = sut.isPasswordValid(password: "123456789abcdefghijk")
        
        // Then
        XCTAssertFalse(isPasswordValid, "Expected 'False' statement when invalid password is provided, but it returns 'True' statement. Probably given password's length is smaller than \(SignUpConstants.passwordMaxLength) or bigger than \(SignUpConstants.passwordMinLength)")
    }
    
    func testSignUpViewModel_whenPasswordNotProvided_shouldReturnFalse() {
        // When
        let isPasswordValid = sut.isPasswordValid(password: nil)
        
        // Then
        XCTAssertFalse(isPasswordValid, "Expected 'False' statement when password is not provided, but it returns 'True' statement.")
    }
    
    func testSignUpViewModel_whenSamePasswordsProvided_shouldReturnTrue() {
        // When
        let doPasswordsMatch = sut.doPasswordsMatch(password: "123456789",
                                                    repeatPassword: "123456789")
        
        // Then
        XCTAssertTrue(doPasswordsMatch, "Expected 'True' statement when same passwords are provided, but it returns 'False' statement. Probably passwords are not same")
    }
    
    func testSignUpViewModel_whenNotSamePasswordsProvided_shouldReturnFalse() {
        // When
        let doPasswordsMatch = sut.doPasswordsMatch(password: "123456789",
                                                    repeatPassword: "abcdefghi")
        
        // Then
        XCTAssertFalse(doPasswordsMatch, "Expected 'False' statement when different passwords are provided, but it returns 'True' statement. Probably passwords are same")
    }
    
    func testSignUpViewModel_whenFirstPasswordNotProvided_shouldReturnFalse() {
        // When
        let doPasswordsMatch = sut.doPasswordsMatch(password: nil,
                                                    repeatPassword: "123456789")
        
        // Then
        XCTAssertFalse(doPasswordsMatch, "Expected 'False' statement when first password is not provided, but it returns 'True' statement.")
    }
    
    func testSignUpViewModel_whenRepeatPasswordNotProvided_shouldReturnFalse() {
        // When
        let doPasswordsMatch = sut.doPasswordsMatch(password: "123456789",
                                                    repeatPassword: nil)
        
        // Then
        XCTAssertFalse(doPasswordsMatch, "Expected 'False' statement when repeat password is not provided, but it returns 'True' statement.")
    }
    
    func testSignUpViewModel_whenPasswordsNotProvided_shouldReturnFalse() {
        // When
        let doPasswordsMatch = sut.doPasswordsMatch(password: nil,
                                                    repeatPassword: nil)
        
        // Then
        XCTAssertFalse(doPasswordsMatch, "Expected 'False' statement when passwords are not provided, but it returns 'True' statement.")
    }
    
    // MARK: - Email Tests
    func testSignUpViewModel_whenValidEmailProvided_shouldReturnTrue() {
        // When
        let isEmailValid = sut.isEmailValid(email: "test@gmail.com")
        
        // Then
        XCTAssertTrue(isEmailValid, "Expected 'True' statement when valid email is provided, but it returns 'False' statement. Probably email is not valid")
    }
    
    func testSignUpViewModel_whenInvalidEmailProvided_shouldReturnFalse() {
        // When
        let isEmailValid = sut.isEmailValid(email: "testgmailcom")
        
        // Then
        XCTAssertFalse(isEmailValid, "Expected 'False' statement when invalid email is provided, but it returns 'True' statement. Probably email is valid")
    }
    
    func testSignUpViewModel_whenEmailNotProvided_shouldReturnFalse() {
        // When
        let isEmailValid = sut.isEmailValid(email: nil)
        
        // Then
        XCTAssertFalse(isEmailValid, "Expected 'False' statement when email is not provided, but it returns 'True' statement.")
    }
    
    // MARK: - Address Tests
    func testSignUpViewModel_whenValidAddressProvided_shouldReturnTrue() {
        // When
        let isAddressValid = sut.isAddressValid(address: Address(country: "testCountry",
                                                                 city: "testCity"))
        
        // Then
        XCTAssertTrue(isAddressValid, "Expected 'True' statement when valid address is provided, but it returns 'False' statement. Probably address is not valid")
    }
    
    func testSignUpViewModel_whenCountryNotProvided_shouldReturnFalse() {
        // When
        let isAddressValid = sut.isAddressValid(address: Address(country: nil,
                                                                 city: "testCity"))
        
        // Then
        XCTAssertFalse(isAddressValid, "Expected 'False' statement when country is not provided, but it returns 'True' statement.")
    }
    
    func testSignUpViewModel_whenCityNotProvided_shouldReturnFalse() {
        // When
        let isAddressValid = sut.isAddressValid(address: Address(country: "testCountry",
                                                                 city: nil))
        
        // Then
        XCTAssertFalse(isAddressValid, "Expected 'False' statement when city is not provided, but it returns 'True' statement.")
    }
    
    func testSignUpViewModel_whenAddressNotProvided_shouldReturnFalse() {
        // When
        let isAddressValid = sut.isAddressValid(address: Address(country: nil,
                                                                 city: nil))
        
        // Then
        XCTAssertFalse(isAddressValid, "Expected 'False' statement when address is not provided, but it returns 'True' statement.")
    }
}
