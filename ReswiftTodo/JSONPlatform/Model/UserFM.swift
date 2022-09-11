//
//  UserFM.swift
//  ReswiftTodo
//
//  Created by iOS Developer on 9/10/22.
//

import Foundation

struct UserFM: Encodable {
    var email: String
    var password: String
}

extension UserFM {
    func toDomain() -> User {
        return User(email: email,
                    password: password)
    }
}

extension User {
    func toFM() -> UserFM {
        return UserFM(email: email,
                      password: password)
    }
}

