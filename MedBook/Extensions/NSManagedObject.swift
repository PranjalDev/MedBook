//
//  NSManagedObject.swift
//  MedBook
//
//  Created by Pranjal Verma on 21/10/23.
//

import Foundation
import CoreData

extension NSManagedObject {
    
    static var entityName: String {
        return String(describing: self)
    }
    
    static func create<T: NSManagedObject>() -> T {
        let context = CoreDataManager.shared.mainContext
        let entityDescription =  NSEntityDescription.entity(forEntityName: entityName, in: context)
       return T.init(entity: entityDescription!,
                     insertInto: context)
    }
    
    static func fetchEntity<T: NSManagedObject>(for parameters: [String: Any]) -> T? {
        let context = CoreDataManager.shared.mainContext
        let predicateFormat = parameters.map { key, _ in
            "\(key) == %@"
        }.joined(separator: " AND ")
        let values = parameters.map { $0.value }
        let predicate = NSPredicate(format: predicateFormat, argumentArray: values)
        return self.fetch(with: predicate, in: context)?.first as? T
    }
    
    static func fetch<T: NSManagedObject>(with predicate: NSPredicate? = nil, in context: NSManagedObjectContext) -> [T]? {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: entityName)
        fetchRequest.predicate = predicate
        return try? context.fetch(fetchRequest) as? [T]
    }
    
   static func isUniqueEmail(_ email: String, in context: NSManagedObjectContext) -> Bool {
       let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: entityName)
        fetchRequest.predicate = NSPredicate(format: "userEmail == %@", email)

        do {
            let results = try context.fetch(fetchRequest)
            return results.isEmpty
        } catch {
            print("Error fetching data: \(error)")
            return false
        }
    }
}
