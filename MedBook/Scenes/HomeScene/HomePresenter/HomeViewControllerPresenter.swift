//
//  HomeViewControllerPresenter.swift
//  MedBook
//
//  Created by Pranjal Verma on 21/10/23.
//

import Foundation

protocol HomeViewControllerPresentationLogic {
    func presentLogout()
}

class HomeViewControllerPresenter: HomeViewControllerPresentationLogic {
    
    weak var viewController: HomeViewControllerDisplayLogic!
    
    func presentLogout() {
        viewController.displayLogout()
    }
}
