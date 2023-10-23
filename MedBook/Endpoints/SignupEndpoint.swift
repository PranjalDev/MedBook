//
//  SignupEndpoint.swift
//  MedBook
//
//  Created by Pranjal Verma on 22/10/23.
//

import Foundation


enum SignupEndpoint {
    case countries
}

extension SignupEndpoint: EndpointType {
    var path: String {
        switch self {
        case .countries:
            return "https://api.first.org/data/v1/countries"
        }
    }
    
    var httpMethod: HTTPMethods {
        switch self {
        case .countries:
            return .get
        }
    }
}
