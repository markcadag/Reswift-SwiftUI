//
//  ObservableAuthState.swift
//  ReswiftTodo
//
//  Created by iOS Developer on 9/12/22.
//

import Foundation
import ReSwift
import CoreData

class ObservableAuthState: ObservableState<AuthenticationState> {

    let container = NSPersistentContainer(name: "ReswiftTodoDb")
 
    override init(store: Store<AuthenticationState>) {
        
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Core data failed to load: \(error.localizedDescription)")
            }
        }
        
        super.init(store: store)
    }
}
