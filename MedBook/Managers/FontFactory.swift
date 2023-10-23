//
//  FontFactory.swift
//  MedBook
//
//  Created by Pranjal Verma on 23/10/23.
//

import UIKit

class FontFactory {

    static func degularFont(size: FontSize) -> UIFont {
        return UIFont(name: "Degular-Regular", size: size.size) ?? UIFont.systemFont(ofSize: size.size)
    }

    static func degularBoldFont(size: FontSize) -> UIFont {
        return UIFont(name: "Degular-Bold", size: size.size) ?? UIFont.boldSystemFont(ofSize: size.size)
    }
    
    static func degularSemiboldFont(size: FontSize) -> UIFont {
        UIFont(name: "Degular-Semibold", size: size.size) ?? UIFont.boldSystemFont(ofSize: size.size)
    }
    
    static func degularMediumFont(size: FontSize) -> UIFont {
        UIFont(name: "Degular-Medium", size: size.size) ?? UIFont.systemFont(ofSize: size.size)
    }
}


enum FontSize {
    case headerFont
    case textFont
    case buttonFont
    case titleFont
    
    var size: CGFloat {
        switch self {
        case .headerFont:
            return 32
        case .textFont:
            return 18
        case .buttonFont:
            return 22
        case .titleFont:
            return 28
        }
    }
}
