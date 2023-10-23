//
//  UserSignupInteractor.swift
//  MedBook
//
//  Created by Pranjal Verma on 22/10/23.
//

import Foundation

protocol UserSignupViewControllerBusinessLogic {
    func fetch(request: UserSignupEntity.Signup.Request)
    func validateAndSaveUserDetail(request: UserSignupEntity.ValidateAndSave.Request)
    func fetchPasswordConditionsModel()
    func checkPasswordStrength(password: String)
}

class UserSignupInteractor: UserSignupViewControllerBusinessLogic {
    
    var presenter: UserSignupPresentationLogic!
    var dataStore: UserSignupDataStore!
    
    let credentialValidator: CredentialValidate = CredentialValidator()
    
    init(presenter: UserSignupPresentationLogic, dataStore: UserSignupDataStore) {
        self.presenter = presenter
        self.dataStore = dataStore
    }
    
    func fetch(request: UserSignupEntity.Signup.Request) {
        Task {
            do {
                let countryData = try await NetworkManager.shared.request(model: CountryModel.self, endpoint: SignupEndpoint.countries)
                self.dataStore.countries = countryData.countries
                await MainActor.run {
                    self.presenter.reloadPickerView(response: UserSignupEntity.Signup.Response(countries: countryData.countries))
                }
            } catch let error {
                // Handle error
                presenter.showAlert(response: UserSignupEntity.ShowAlert.Response(title: error.localizedDescription, message: nil))
            }
        }
    }
    
    func validateAndSaveUserDetail(request: UserSignupEntity.ValidateAndSave.Request) {
        
        guard let email = request.email, credentialValidator.isValidEmail(email) else {
            presenter.showAlert(response: UserSignupEntity.ShowAlert.Response(title: "Valid email required"))
            return
        }
        guard let password = request.password, !password.isEmpty else {
            presenter.showAlert(response: UserSignupEntity.ShowAlert.Response(title: "Valid password required"))
            return
        }
        guard credentialValidator.checkPasswordStrength(password).allSatisfy({ $0 }) else {
            presenter.showAlert(response: UserSignupEntity.ShowAlert.Response(title: "Password must be strong"))
            return
        }
        
        let user = User(userEmail: email, userPassword: password, userCountry: request.selectedCountry, loginStatus: true)
        UserSessionManager.shared.save(user: user)
        presenter.routeToHomeVC()
    }
    
    func fetchPasswordConditionsModel() {
        presenter.presentPasswordConditions(response: UserSignupEntity.PasswordCondition.Response(passwordConditions: dataStore.passwordConditions))
    }
    
    func checkPasswordStrength(password: String) {
        let passConditions = credentialValidator.checkPasswordStrength(password)
        
        for condition in 0..<passConditions.count {
            dataStore.passwordConditions[condition].isSatisfied = passConditions[condition]
        }
        
        presenter.presentPasswordConditions(response: UserSignupEntity.PasswordCondition.Response(passwordConditions: dataStore.passwordConditions))
    }
}
