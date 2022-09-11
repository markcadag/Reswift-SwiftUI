//
//  Store.swift
//  ReswiftTodo
//
//  Created by iOS Developer on 9/10/22.
//

import Foundation
import ReSwift
import ReSwiftThunk

let noteThunkMiddleWare: Middleware<NoteState> = createThunkMiddleware()

let noteStore = Store<NoteState>(reducer: notesReducer,state: NoteState(), middleware: [noteThunkMiddleWare])
