//
//  CredentialValidator.swift
//  MedBook
//
//  Created by Pranjal Verma on 22/10/23.
//

import Foundation

protocol CredentialValidate {
    func isValidEmail(_ email: String) -> Bool
    func checkPasswordStrength(_ password: String) -> [Bool]
}


struct CredentialValidator: CredentialValidate {
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: email)
    }
    
    func checkPasswordStrength(_ password: String) -> [Bool] {
        let lengthCondition = password.count > 7
        let uppercaseCondition = password.rangeOfCharacter(from: .uppercaseLetters) != nil
        let specialChar = "!@#$%^&*()-_=+\\|[{]};:'\",<.>/?"
        let specialCharCondition = password.rangeOfCharacter(from: CharacterSet(charactersIn: specialChar)) != nil
        return [lengthCondition, uppercaseCondition, specialCharCondition]
    }
    
}
