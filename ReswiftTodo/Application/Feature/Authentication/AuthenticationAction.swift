//
//  AuthenticationNote.swift
//  ReswiftTodo
//
//  Created by iOS Developer on 9/11/22.
//

import Foundation

import ReSwift

enum AuthenticationAction: Action {
    case authenticated(authenticated: Bool)
    case email(email: String)
    case password(password: String)
    case error(error: String)
    case showAlert(show: Bool)
    case getUser(user: User)
}
