//
//  Reducer.swift
//  ReswiftTodo
//
//  Created by iOS Developer on 9/11/22.
//

import Foundation

import ReSwift

func navigationReducer(action: Action, state: NavigationState?) -> NavigationState {
    var state = state ?? NavigationState()

    guard let action = action as? NavigationAction else {
        return state
    }
    
    switch action {
    case .navigate(let tagName):
        state.tagName = tagName
    }

    return state
}
