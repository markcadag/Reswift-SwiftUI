//
//  AuthenticationStore.swift
//  ReswiftTodo
//
//  Created by iOS Developer on 9/11/22.
//
import ReSwift
import ReSwiftThunk

let authenticationThunkMiddleWare: Middleware<AuthenticationState> = createThunkMiddleware()

let authenticationStore = Store<AuthenticationState>(reducer: authenticationReducer,state: AuthenticationState(), middleware: [authenticationThunkMiddleWare])
