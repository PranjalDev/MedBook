//
//  UserSignupDataStore.swift
//  MedBook
//
//  Created by Pranjal Verma on 22/10/23.
//

import Foundation

class UserSignupDataStore {
    var countries: [Country] = []
    var passwordConditions: [PasswordConditionModel] = [PasswordConditionModel(isSatisfied: false, condition: "At least 8 characters"), PasswordConditionModel(isSatisfied: false, condition: "Must contain an uppercase letter"), PasswordConditionModel(isSatisfied: false, condition: "Contains a special character")]
}
