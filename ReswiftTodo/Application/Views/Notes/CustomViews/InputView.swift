//
//  InputView.swift
//  ReswiftTodo
//
//  Created by iOS Developer on 9/10/22.
//

import Foundation
import SwiftUI

struct InputView: View {
    
    @State var taskText: String
    @State var didTapAddTask: Bool
    
    var body: some View {
        HStack {
            TextField("Write a note ...", text: $taskText)
                .padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
                .clipped()
//            Button(action: didTapAddTask, label: { Text("Add") }).padding(8)
        }
    }
}
