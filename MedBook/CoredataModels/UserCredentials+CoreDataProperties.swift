//
//  UserCredentials+CoreDataProperties.swift
//  MedBook
//
//  Created by Pranjal Verma on 22/10/23.
//
//

import Foundation
import CoreData


extension UserCredentials {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<UserCredentials> {
        return NSFetchRequest<UserCredentials>(entityName: "UserCredentials")
    }

    @NSManaged public var country: String?
    @NSManaged public var userEmail: String?
    @NSManaged public var userId: UUID?
    @NSManaged public var userPassword: String?
    @NSManaged public var loginStatus: Bool

}

extension UserCredentials : Identifiable {

}
