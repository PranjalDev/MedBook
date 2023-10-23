//
//  UserLoginConfigurator.swift
//  MedBook
//
//  Created by Pranjal Verma on 22/10/23.
//

import Foundation


struct UserLoginConfigurator {
    static func configure(view: UserLoginViewController) {
        
        let dataStore = UserLoginDataStore()
        let router = UserLoginRouter()
        router.dataStore = dataStore
        router.viewController = view
        
        let presenter = UserLoginPresenter()
        presenter.viewController = view
        
        let interactor = UserLoginInteractor(presenter: presenter, dataStore: dataStore)
        view.interactor = interactor
        view.router = router
    }
}
