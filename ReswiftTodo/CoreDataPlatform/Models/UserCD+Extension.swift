//
//  UserCD.swift
//  ReswiftTodo
//
//  Created by iOS Developer on 9/11/22.
//

import Foundation
import CoreData


protocol DomainConvertable {
    associatedtype T
    func asDomain() -> T
}

extension UserCD: DomainConvertable {
    func asDomain() -> User {
        return User(email: email ?? "",
                    password: password ?? "")
    }
}

