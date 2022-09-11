//
//  Reducer.swift
//  ReswiftTodo
//
//  Created by iOS Developer on 9/10/22.
//

import ReSwift


func notesReducer(action: Action, state: NoteState?) -> NoteState {
    var state = state ?? NoteState()

    guard let action = action as? NoteAction else {
        return state
    }
    
    switch action {
    case .addTodo(let note):
        state.notes?.append(note)
    case .listTodo(let notes):
        state.notes = notes
    case .selectIndexToBeDeleted(let index):
        state.indexToBeDeleted = index
    case .deleteTodo(let index):
        state.notes?.remove(at: index)
    case .showAlert(let show):
        state.showAlert = show
    case .noteText(let text):
        state.noteText = text
    case .showErrorAlert(let show):
        state.showErrorAlert = show
    case .errorText(let text):
        state.errorText = text
    }

    return state
}

