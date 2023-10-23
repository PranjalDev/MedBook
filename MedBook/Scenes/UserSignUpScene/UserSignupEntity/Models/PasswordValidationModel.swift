//
//  PasswordValidationModel.swift
//  MedBook
//
//  Created by Pranjal Verma on 22/10/23.
//

import Foundation
import UIKit

struct PasswordConditionModel {
    var isSatisfied: Bool
    var condition: String
    
    var image: UIImage? {
        isSatisfied ? UIImage(systemName: "checkmark.square.fill") : UIImage(systemName: "square")
    }
}
