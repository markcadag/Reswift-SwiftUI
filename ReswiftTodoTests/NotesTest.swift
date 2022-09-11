//
//  NotesTest.swift
//  ReswiftTodoTests
//
//  Created by iOS Developer on 9/12/22.
//

import Foundation
@testable import ReswiftTodo

import Quick
import Nimble
import SwiftUI
import CommonCrypto

class NotesTest: QuickSpec {
    override func spec() {
        describe("Notes Feature") {
            context("Can manage notes") {
                it("can save note with valid user") {
                    
                    KeyChainManager.shared.save(user: User(email: "markcadag@gmail.com", password: "12345"))
                    
                    @ObservedObject var state = ObservableState<NoteState>(store: noteStore)
                    state.dispatch(NoteAction.noteText(text: "20"))
                    state.dispatch(addNoteThunk(note: Note(time_stamp: Date().currentTimeMillis(), text: "Sample")))
                    
                    expect(state.current.notes?.count).toEventually(beGreaterThanOrEqualTo(1), timeout: .seconds(5))
                }
                
            }
        }
  }
}
