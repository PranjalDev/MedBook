//
//  UserSignupEntity.swift
//  MedBook
//
//  Created by Pranjal Verma on 22/10/23.
//

import Foundation


enum UserSignupEntity {
    
    enum Signup {
        struct Request {
            
        }
        
        struct Response {
            var countries: [Country]
        }
        
        struct ViewModel {
            var countries: [Country]
        }
    }
    
    enum ValidateAndSave {
        struct Request {
            var email: String?
            var password: String?
            var selectedCountry: String
        }
        
        struct Response {
            var title: String?
            var message: String?
        }
        
        struct ViewModel {
            var title: String?
            var message: String?
        }
    }
    
    enum ShowAlert {
        struct Response {
            var title: String?
            var message: String?
        }
        
        struct ViewModel {
            var title: String?
            var message: String?
        }
    }
    
    enum PasswordCondition {
        struct Response {
            var passwordConditions: [PasswordConditionModel]
        }
        
        struct ViewModel {
            var passwordConditions: [PasswordConditionModel]
        }
    }
}
