//
//  UserLoginRouter.swift
//  MedBook
//
//  Created by Pranjal Verma on 22/10/23.
//

import Foundation


protocol UserLoginRoutingLogic {
    func routeToHomeVC()
}

protocol UserLoginDataPassing {
    var dataStore: UserLoginDataStore! { get set }
}

class UserLoginRouter: NSObject, UserLoginRoutingLogic, UserLoginDataPassing {
    var dataStore: UserLoginDataStore!
    weak var viewController: UserLoginViewController!
    
    func routeToHomeVC() {
        viewController.showViewController(with: HomeViewController())
    }
}
