//
//  AuthenticationReducer.swift
//  ReswiftTodo
//
//  Created by iOS Developer on 9/11/22.
//

import ReSwift

func authenticationReducer(action: Action, state: AuthenticationState?) -> AuthenticationState {
    var state = state ?? AuthenticationState()

    guard let action = action as? AuthenticationAction else {
        return state
    }
    
    switch action {
    case .error(let error):
        state.errorString = error
    case .authenticated(let authenticated):
        state.isAuthenticated = authenticated
    case .email(let email):
        state.email = email
    case .password(let password):
        state.password = password
    case .showAlert(let show):
        state.showAlert = show
    case .getUser(let user):
        state.user = user
    }

    return state
}
