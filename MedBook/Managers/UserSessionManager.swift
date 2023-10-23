//
//  UserSessionManager.swift
//  MedBook
//
//  Created by Pranjal Verma on 21/10/23.
//

import Foundation


struct User {
    var userEmail: String
    var userPassword: String
    var userCountry: String
    var loginStatus: Bool
}


class UserSessionManager {
    static let shared = UserSessionManager()
    private init() {}
    
    private var user: User?
    
    func save(user: User) {
        self.user = user
        let userCredential: UserCredentials = UserCredentials.create()
        
        userCredential.userEmail = user.userEmail
        userCredential.country = user.userCountry
        userCredential.userPassword = user.userPassword
        userCredential.loginStatus = user.loginStatus
        CoreDataManager.shared.saveContext()
    }
    
    func fetch(user withEmail: String, and pass: String) -> UserCredentials? {
        UserCredentials.fetchEntity(for: ["userEmail": withEmail, "userPassword": pass]) as? UserCredentials
    }
    
    func fetchUser(with loginStatus: Bool) -> UserCredentials? {
        UserCredentials.fetchEntity(for: ["loginStatus": loginStatus]) as? UserCredentials
    }
    
}
