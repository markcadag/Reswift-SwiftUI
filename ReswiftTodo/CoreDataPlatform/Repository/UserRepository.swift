//
//  UserRepository.swift
//  ReswiftTodo
//
//  Created by iOS Developer on 9/11/22.
//

import Foundation
import CoreData

protocol UserRepositoryImpl {
    func searchUser(predicate: NSPredicate?) -> Result<[User], Error>
    func create(user: User) -> Result<Bool, Error>
}

class UserRepository {
    private let repository: Repository<UserCD>
    init(context: NSManagedObjectContext) {
        self.repository = Repository<UserCD>(context: context)
    }
}

extension UserRepository: UserRepositoryImpl {
    @discardableResult func searchUser(predicate: NSPredicate?) -> Result<[User], Error> {
        let result = repository.get(predicate: predicate, sortDescriptors: nil)
        switch result {
        case .success(let usersCD):
            let books = usersCD.map {
                return $0.asDomain()
            }
            
            return .success(books)
        case .failure(let error):
            return .failure(error)
        }
    }
    
    @discardableResult func create(user: User) -> Result<Bool, Error> {
        let result = repository.create()
        switch result {
        case .success(let userCD):
            userCD.email = user.email
            userCD.password = user.password
            return .success(true)

        case .failure(let error):
            return .failure(error)
        }
    }
    
}
