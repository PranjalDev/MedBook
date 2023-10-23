//
//  UserLoginEntity.swift
//  MedBook
//
//  Created by Pranjal Verma on 22/10/23.
//

import Foundation


enum UserLoginEntity {
    
    enum login {
        struct Request {
            var email: String?
            var password: String?
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
    
}
