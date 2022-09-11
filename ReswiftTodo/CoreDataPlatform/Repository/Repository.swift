//
//  Repository.swift
//  ReswiftTodo
//
//  Created by iOS Developer on 9/11/22.
//

import Foundation
import CoreData

enum CoreDataError: Error {
    case invalidManagedObjectType
}

final class Repository<T: NSManagedObject> {
    typealias Entity = T
    
    private let context: NSManagedObjectContext

    init(context: NSManagedObjectContext) {
        self.context = context
    }
    
    func get(predicate: NSPredicate?, sortDescriptors: [NSSortDescriptor]?) -> Result<[Entity], Error> {
         let fetchRequest = Entity.fetchRequest()
         fetchRequest.predicate = predicate
         fetchRequest.sortDescriptors = sortDescriptors
         do {
             if let fetchResults = try context.fetch(fetchRequest) as? [Entity] {
                 return .success(fetchResults)
             } else {
                 return .failure(CoreDataError.invalidManagedObjectType)
             }
         } catch {
             return .failure(error)
         }
     }
    
    func create() -> Result<Entity, Error> {
       let className = String(describing: Entity.self)
       guard let managedObject = NSEntityDescription.insertNewObject(forEntityName: className, into: context) as? Entity else {
           return .failure(CoreDataError.invalidManagedObjectType)
       }
       return .success(managedObject)
   }
}
