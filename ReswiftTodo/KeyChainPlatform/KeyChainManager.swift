//
//  KeyChainManager.swift
//  ReswiftTodo
//
//  Created by iOS Developer on 9/10/22.
//

import KeychainSwift


class KeyChainManager {
    
    static let shared = KeyChainManager(keychainSwift: KeychainSwift())

    let keychainSwift: KeychainSwift

    // Initialization
    
    init(keychainSwift: KeychainSwift) {
        self.keychainSwift = keychainSwift
    }
    
    
    func save(user: User) {
        keychainSwift.set(user.email, forKey: "email")
    }
    
    func getUser() -> User {
        return User(email: keychainSwift.get("email") ?? "", password: "")
    }

}
