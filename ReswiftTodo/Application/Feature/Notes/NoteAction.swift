//
//  Action.swift
//  ReswiftTodo
//
//  Created by iOS Developer on 9/10/22.
//

import ReSwift

enum NoteAction: Action {
    case listTodo(notes: [Note])
    case selectIndexToBeDeleted(index: Int)
    case addTodo(note: Note)
    case showAlert(show: Bool)
    case deleteTodo(index: Int)
    case noteText(text: String)
    case showErrorAlert(show: Bool)
    case errorText(text: String)
}
