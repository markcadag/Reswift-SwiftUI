//
//  UserCD+CoreDataProperties.swift
//  ReswiftTodo
//
//  Created by iOS Developer on 9/11/22.
//
//

import Foundation
import CoreData


extension UserCD {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<UserCD> {
        return NSFetchRequest<UserCD>(entityName: "UserCD")
    }

    @NSManaged public var email: String?
    @NSManaged public var password: String?

}

extension UserCD : Identifiable {

}
