//
//  UIViewController+Extension.swift
//  MedBook
//
//  Created by Pranjal Verma on 22/10/23.
//

import UIKit

extension UIViewController {
    
    private func resetWindow(with vc: UIViewController?) {
        guard let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate, let vc else {
            fatalError("could not get sceneDelegate or vc")
        }
        let navigationController = UINavigationController(rootViewController: vc)
        sceneDelegate.window?.rootViewController = navigationController
    }
    
    func showViewController(with viewController: UIViewController) {
        resetWindow(with: viewController)
    }
}
