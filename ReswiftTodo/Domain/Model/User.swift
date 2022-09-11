//
//  User.swift
//  ReswiftTodo
//
//  Created by iOS Developer on 9/10/22.
//

import Foundation

struct User: Encodable, Decodable {
    var email: String
    // sha256
    var password: String
}
