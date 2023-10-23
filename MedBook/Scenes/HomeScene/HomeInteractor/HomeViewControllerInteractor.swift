//
//  HomeViewControllerInteractor.swift
//  MedBook
//
//  Created by Pranjal Verma on 21/10/23.
//

import Foundation

protocol HomeViewControllerBusinessLogic {
    func logoutUser()
}

class HomeViewControllerInteractor: HomeViewControllerBusinessLogic {
    
    var dataStore: HomeViewControllerDataStore!
    var presenter: HomeViewControllerPresentationLogic!
    
    init(dataStore: HomeViewControllerDataStore, presenter: HomeViewControllerPresentationLogic) {
        self.dataStore = dataStore
        self.presenter = presenter
    }
    
    func logoutUser() {
        let user = UserSessionManager.shared.fetchUser(with: true)
        user?.loginStatus = false
        CoreDataManager.shared.saveContext()
        presenter.presentLogout()
    }
}
