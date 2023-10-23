//
//  UserSignupRouter.swift
//  MedBook
//
//  Created by Pranjal Verma on 22/10/23.
//

import Foundation

protocol UserSignupRoutingLogic {
    func routeToHomeVC()
}

protocol UserSignupDataPassing {
    var dataStore: UserSignupDataStore! { get set }
}

class UserSignupRouter: NSObject, UserSignupRoutingLogic, UserSignupDataPassing {
    var dataStore: UserSignupDataStore!
    weak var viewController: UserSignupViewController!
    
    func routeToHomeVC() {
        viewController.showViewController(with: HomeViewController())
    }
}
