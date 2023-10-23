//
//  UserSignupPresenter.swift
//  MedBook
//
//  Created by Pranjal Verma on 22/10/23.
//

import Foundation

protocol UserSignupPresentationLogic {
    func reloadPickerView(response: UserSignupEntity.Signup.Response)
    func showAlert(response: UserSignupEntity.ShowAlert.Response)
    func routeToHomeVC()
    func presentPasswordConditions(response: UserSignupEntity.PasswordCondition.Response)
}

class UserSignupPresenter: UserSignupPresentationLogic {
    
    weak var viewController: UserSignupViewControllerDisplayLogic!
    
    func reloadPickerView(response: UserSignupEntity.Signup.Response) {
        viewController.display(viewModel: UserSignupEntity.Signup.ViewModel(countries: response.countries))
    }
    
    func showAlert(response: UserSignupEntity.ShowAlert.Response) {
        viewController.displayAlert(viewModel: UserSignupEntity.ShowAlert.ViewModel(title: response.title, message: response.message))
    }
    
    func routeToHomeVC() {
        viewController.routeToHomeVC()
    }
    
    func presentPasswordConditions(response: UserSignupEntity.PasswordCondition.Response) {
        viewController.displayPasswordConditions(viewModel: UserSignupEntity.PasswordCondition.ViewModel(passwordConditions: response.passwordConditions))
    }
}
