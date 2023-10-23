//
//  UserLoginInteractor.swift
//  MedBook
//
//  Created by Pranjal Verma on 22/10/23.
//

import Foundation

protocol UserLoginViewControllerBusinessLogic {
    func validateCredentials(request: UserLoginEntity.login.Request)
}

class UserLoginInteractor: UserLoginViewControllerBusinessLogic {
    var presenter: UserLoginPresentationLogic!
    var dataStore: UserLoginDataStore!
    
    let credentialValidator: CredentialValidate = CredentialValidator()
    
    init(presenter: UserLoginPresentationLogic, dataStore: UserLoginDataStore) {
        self.presenter = presenter
        self.dataStore = dataStore
    }
    
    func validateCredentials(request: UserLoginEntity.login.Request) {
        guard let email = request.email, credentialValidator.isValidEmail(email) else {
            presenter.showAlert(response: UserLoginEntity.login.Response(title: "Valid email required", message: nil))
            return
        }
        guard let password = request.password, !password.isEmpty else {
            presenter.showAlert(response: UserLoginEntity.login.Response(title: "Valid password required", message: nil))
            return
        }
        guard let user = UserSessionManager.shared.fetch(user: email, and: password) else {
            presenter.showAlert(response: UserLoginEntity.login.Response(title: "The email or password is incorrect", message: nil))
            return
        }
        user.loginStatus = true
        CoreDataManager.shared.saveContext()
        presenter.routeToHomeVC()
    }
}
