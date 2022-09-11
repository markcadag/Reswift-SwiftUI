//
//  NoteThunk.swift
//  ReswiftTodo
//
//  Created by iOS Developer on 9/10/22.
//

import Foundation
import ReSwiftThunk



func fetchNotesThunk() -> Thunk<NoteState> {
    return Thunk<NoteState> { dispatch, getState in
        if getState() != nil {
            // use use case here
            let email = KeyChainManager.shared.getUser().email
            let fileManagerUtil = FileManagerUtil<Note>(fileName: email + ".json")
            let notes = fileManagerUtil.loadObjects()
            dispatch(NoteAction.listTodo(notes: notes))
        } else {
            return
        }
    }
}

func addNoteThunk(note: Note) -> Thunk<NoteState> {
    return Thunk<NoteState> { dispatch, getState in
        if let state = getState() {
            if state.noteText.isBlank {
                dispatch(NoteAction.showErrorAlert(show: true))
                dispatch(NoteAction.errorText(text: "Notes text cannot be empty"))
                return
            }
            
            let email = KeyChainManager.shared.getUser().email
            let fileManagerUtil = FileManagerUtil<Note>(fileName: email + ".json")
            if fileManagerUtil.saveObject(item: note) {
                dispatch(NoteAction.addTodo(note: note))
                dispatch(NoteAction.noteText(text: ""))
            }
        } else {
            return
        }
    }
}


func deleteNoteThunk() -> Thunk<NoteState> {
    return Thunk<NoteState> { dispatch, getState in
        if let state = getState(), let indexToBeDeleted = state.indexToBeDeleted {
            let email = KeyChainManager.shared.getUser().email
            let fileManagerUtil = FileManagerUtil<Note>(fileName: email + ".json")
            if fileManagerUtil.deleteItemAt(index: indexToBeDeleted) {
                dispatch(NoteAction.deleteTodo(index: indexToBeDeleted))
            }
        } else {
            return
        }
    }
}

