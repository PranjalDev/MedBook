//
//  HomeConfigurator.swift
//  MedBook
//
//  Created by Pranjal Verma on 21/10/23.
//

import Foundation


struct HomeConfigurator {
    static func configure(view: HomeViewController) {
        
        let dataStore = HomeViewControllerDataStore()
        let router = HomeRouter()
        router.dataStore = dataStore
        router.viewController = view
        
        let presenter = HomeViewControllerPresenter()
        presenter.viewController = view
        
        let interactor = HomeViewControllerInteractor(dataStore: dataStore, presenter: presenter)
        view.interactor = interactor
        view.router = router
    }
}
