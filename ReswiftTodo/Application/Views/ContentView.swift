//
//  ContentView.swift
//  ReswiftTodo
//
//  Created by iOS Developer on 9/10/22.
//

import SwiftUI
import ReSwift

struct ContentView: View {
    
    // MARK: Private Properties

    // MARK: Body
    
    var body: some View {
        
        
        NavigationView {
            VStack(spacing: 30) {
                Text("You're going to flip a coin – do you want to choose heads or tails?")

                NavigationLink(destination: NotesView()) {
                    Text("Open notes")
                }
            }
            .navigationTitle("Navigation")
        }
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

