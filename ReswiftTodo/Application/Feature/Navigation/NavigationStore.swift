//
//  NavigationSotre.swift
//  ReswiftTodo
//
//  Created by iOS Developer on 9/11/22.
//

import Foundation
import ReSwift


let navigationStore = Store<NavigationState>(reducer: navigationReducer,state: NavigationState(), middleware: [])
