//
//  UserLoginPresenter.swift
//  MedBook
//
//  Created by Pranjal Verma on 22/10/23.
//

import Foundation

protocol UserLoginPresentationLogic {
    func showAlert(response: UserLoginEntity.login.Response)
    func routeToHomeVC()
}

class UserLoginPresenter: UserLoginPresentationLogic {
    func routeToHomeVC() {
        viewController.routeToHomeVC()
    }
    
    func showAlert(response: UserLoginEntity.login.Response) {
        viewController.displayAlert(viewModel: UserLoginEntity.login.ViewModel(title: response.title, message: response.message))
    }
    
    weak var viewController: UserLoginViewControllerDisplayLogic!
}
