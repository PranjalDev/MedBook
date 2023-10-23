//
//  UIAlertController+Extension.swift
//  MedBook
//
//  Created by Pranjal Verma on 22/10/23.
//

import UIKit

extension UIAlertController {
    static func showAlert(title: String, message: String, defaultAction: UIAlertAction = UIAlertAction(title: "OK", style: .default, handler: {_ in }), present: UIViewController, completion: @escaping (() -> Void) = {}) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(defaultAction)
        present.present(alert, animated: true)
    }
}
