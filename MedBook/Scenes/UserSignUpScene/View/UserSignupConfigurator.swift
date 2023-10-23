//
//  UserSignupConfigurator.swift
//  MedBook
//
//  Created by Pranjal Verma on 22/10/23.
//

import Foundation

struct UserSignupConfigurator {
    static func configure(view: UserSignupViewController) {
        
        let dataStore = UserSignupDataStore()
        let router = UserSignupRouter()
        router.dataStore = dataStore
        router.viewController = view
        
        let presenter = UserSignupPresenter()
        presenter.viewController = view
        
        let interactor = UserSignupInteractor(presenter: presenter, dataStore: dataStore)
        view.interactor = interactor
        view.router = router
    }
}
