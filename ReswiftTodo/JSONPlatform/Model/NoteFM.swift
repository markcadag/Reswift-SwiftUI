//
//  Notes.swift
//  ReswiftTodo
//
//  Created by iOS Developer on 9/10/22.
//

import Foundation

struct NoteFM {
    var time_stamp: Int64
    var text: String
}

extension NoteFM {
    func toDomain() -> Note {
        return Note(time_stamp: time_stamp,
                    text: text)
    }
}

extension Note {
    func toFM() -> NoteFM {
        return NoteFM(time_stamp: time_stamp,
                      text: text)
    }
}

