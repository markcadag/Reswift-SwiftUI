//
//  AuthenticationThunk.swift
//  ReswiftTodo
//
//  Created by iOS Developer on 9/11/22.
//

import Foundation
import ReSwiftThunk
import KeychainSwift
import CoreData

func signIn(context: NSManagedObjectContext) -> Thunk<AuthenticationState> {
    return Thunk<AuthenticationState> { dispatch, getState in
        if let state = getState() {
            if state.email.isBlank || state.password.isBlank {
                dispatch(AuthenticationAction.showAlert(show: true))
                dispatch(AuthenticationAction.error(error: "All fields are required"))
                return
            }
            
            if !state.email.isValidEmail() {
                dispatch(AuthenticationAction.showAlert(show: true))
                dispatch(AuthenticationAction.error(error: "Invalid Email format"))
                return
            }
            
            let userRepository = UserRepository(context: context)
            let result = userRepository.searchUser(predicate: NSPredicate(format: "email = %@", state.email!))
            switch result {
            case .success(let users):
                if users.count < 1 {
                    dispatch(AuthenticationAction.showAlert(show: true))
                    dispatch(AuthenticationAction.error(error: "Email Does Not Exists"))
                    return
                }
                let emailPredicate = NSPredicate(format: "email = %@", state.email!)
                let passwordPredicate = NSPredicate(format: "password = %@", state.password!.sha256(salt: "SALT").hexString)
                let predicate  = NSCompoundPredicate(andPredicateWithSubpredicates: [emailPredicate,passwordPredicate] )
                let result = userRepository.searchUser(predicate: predicate)
                
                switch result {
                case .success(let users):
                    if users.count < 1 {
                        dispatch(AuthenticationAction.showAlert(show: true))
                        dispatch(AuthenticationAction.error(error: "Invalid Password"))
                        return
                    } else {
                        KeyChainManager.shared.save(user: users[0])
                        dispatch(AuthenticationAction.getUser(user: users[0]))
                        dispatch(AuthenticationAction.authenticated(authenticated: true))
                    }
                case .failure(_):
                    break
                }
                break
                
            case .failure(_):
                break
            }
            
        } else {
            return
        }
    }
}

func register(context: NSManagedObjectContext) -> Thunk<AuthenticationState> {
    return Thunk<AuthenticationState> { dispatch, getState in
        if let state = getState() {
            
            if state.email.isBlank || state.password.isBlank {
                dispatch(AuthenticationAction.showAlert(show: true))
                dispatch(AuthenticationAction.error(error: "All fields are required"))
                return
            }
            
        
            if !state.email.isValidEmail() {
                dispatch(AuthenticationAction.showAlert(show: true))
                dispatch(AuthenticationAction.error(error: "Invalid Email format"))
                return
            }
            
            let user = User(email: state.email!, password: state.password!.sha256(salt: "SALT").hexString)
            let userRepository = UserRepository(context: context)
            let result = userRepository.searchUser(predicate: NSPredicate(format: "email = %@", state.email!))
            switch result {
            case .success(let users):
                if users.count > 1 {
                    dispatch(AuthenticationAction.showAlert(show: true))
                    dispatch(AuthenticationAction.error(error: "Email Already Exists"))
                    return
                }
                
                userRepository.create(user: user)
                do {
                    try context.save()
                    KeyChainManager.shared.save(user: user)
                    dispatch(AuthenticationAction.authenticated(authenticated: true))
                } catch {
                    context.rollback()
                }
                
                break
                
            case .failure(_):
                break
            }
          
           
        } else {
            return
        }
    }
}

func signOut() -> Thunk<AuthenticationState> {
    return Thunk<AuthenticationState> { dispatch, getState in
        if getState() != nil {
            KeyChainManager.shared.save(user: User(email: "", password: ""))
            dispatch(AuthenticationAction.email(email: ""))
            dispatch(AuthenticationAction.password(password: ""))
            dispatch(AuthenticationAction.authenticated(authenticated: false))
            return
        } else {
            return
        }
    }
}

