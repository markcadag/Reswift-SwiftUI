//
//  NotesView.swift
//  ReswiftTodo
//
//  Created by iOS Developer on 9/10/22.
//

import SwiftUI

struct NotesView : View {
    
    @State var taskText: String = ""
    
    @ObservedObject private var state = ObservableState<NoteState>(store: noteStore)
    @ObservedObject private var navigationState = ObservableState<NavigationState>(store: navigationStore)
    @EnvironmentObject var authenticationState: ObservableAuthState
    
    var alert: Alert {
        Alert(title: Text("Hey!"),
              message: Text("Are you sure you want to delete this item?"),
              primaryButton: .destructive(Text("Delete"), action: deleteNote),
              secondaryButton: .cancel())
    }
    
    var inputView: some View {
        HStack {
            TextField("Write a note ...", text:  Binding(
                get: { state.current.noteText ?? "" },
                set: { value in
                    state.dispatch(NoteAction.noteText(text: value))
                }
            )).padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
                .clipped()
            Button(action: didTapAddTask, label: { Text("Add") }).padding(8)
            Button(action: didTapSignout, label: { Text("Sign out") }).padding(8)
        }
    }
    
    var body: some View {
        VStack {
            inputView
            Divider()
            List {
                ForEach(Array(state.current.notes?.enumerated() ?? [].enumerated()), id: \.element) {
                    index, element in
                    VStack(alignment: .leading) {
                        Text(element.text).font(.headline)
                        Text(element.time_stamp.toFormattedDate()).lineLimit(nil).multilineTextAlignment(.leading)
                    }
                    .onTapGesture {  }
                    .onLongPressGesture {
                        state.dispatch(NoteAction.selectIndexToBeDeleted(index: index))
                        state.dispatch(NoteAction.showAlert(show: true))
                    }
                }
            }.alert(isPresented: Binding(
                get: { state.current.showAlert ?? false },
                set: { value in
                    state.dispatch(NoteAction.showAlert(show: value))
                }
            ) , content: {
                alert
            }).alert(isPresented: Binding(
                get: { state.current.showErrorAlert ?? false },
                set: { value in
                    state.dispatch(NoteAction.showErrorAlert(show: value))
                }
            ) , content: {
                Alert(title: Text("Hey!"),
                      message: Text(state.current.errorText ?? ""))
            })
        }.onAppear {
            state.dispatch(fetchNotesThunk())
        }.navigationTitle("")
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
    }
    
    private func didTapAddTask() {
        let note = Note(time_stamp: Date().currentTimeMillis(), text: state.current.noteText ?? "")
        state.dispatch(addNoteThunk(note: note))
    }
    
    private func didTapSignout() {
        authenticationState.dispatch(signOut())
    }
    
    private func deleteNote() {
        state.dispatch(deleteNoteThunk())
    }
}

struct NotesView_Previews: PreviewProvider {
    static var previews: some View {
        NotesView()
    }
}
