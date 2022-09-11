//
//  AppState.swift
//  ReswiftTodo
//
//  Created by iOS Developer on 9/10/22.
//

import Foundation
import ReSwift
import SwiftUI

struct NoteState {
    var notes: [Note]?
    var showAlert: Bool?
    var indexToBeDeleted: Int?
    var noteText: String?
    var showErrorAlert: Bool?
    var errorText: String?
}
