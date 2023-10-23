//
//  HomeRouter.swift
//  MedBook
//
//  Created by Pranjal Verma on 21/10/23.
//

import Foundation


protocol HomeRoutingLogic {
    func routeToLandingVC()
}

protocol HomeViewControllerDataPassing {
    var dataStore: HomeViewControllerDataStore! { get }
}

class HomeRouter: NSObject, HomeRoutingLogic, HomeViewControllerDataPassing {
    var dataStore: HomeViewControllerDataStore!
    weak var viewController: HomeViewController!
    
    func routeToLandingVC() {
        let landingVC = LandingViewController()
        viewController.showViewController(with: landingVC)
    }
}
