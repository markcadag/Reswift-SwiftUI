//
//  ReswiftTodoApp.swift
//  ReswiftTodo
//
//  Created by iOS Developer on 9/10/22.
//

import SwiftUI
import CoreData


@main
struct ReswiftTodoApp: App {
    
    @ObservedObject private var state = ObservableAuthState(store: authenticationStore)
    @ObservedObject private var navigationState = ObservableState<NavigationState>(store: navigationStore)
    
    var body: some Scene {
        
        let selection = Binding<String?>(
            get: { navigationState.current.tagName },
            set: { value in
                navigationState.dispatch(NavigationAction.navigate(tagName:  value ?? ""))
            }
        )
        
        WindowGroup {
            NavigationView {
                VStack {
                    if state.current.isAuthenticated ?? false {
                        NotesView().environmentObject(state)
                    } else {
                        NavigationLink(destination: LoginView(),
                                       tag: NavigationTag.loginView.rawValue,
                                       selection: selection) { EmptyView() }
                        
                        NavigationLink(destination: RegistrationView(),
                                       tag: NavigationTag.registrationView.rawValue,
                                       selection: selection) { EmptyView() }
                        
                        NavigationLink(destination: NotesView(),
                                       tag: NavigationTag.notesView.rawValue,
                                       selection: selection) { EmptyView() }
                        
                        LoginView().environment(\.managedObjectContext, state.container.viewContext)
                                            .environmentObject(state)
                    }
                }
            }.environment(\.managedObjectContext, state.container.viewContext)
            .environmentObject(state)
        }
    }
}
