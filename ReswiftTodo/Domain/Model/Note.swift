//
//  Notes.swift
//  ReswiftTodo
//
//  Created by iOS Developer on 9/10/22.
//

import Foundation

struct Note: Decodable, Encodable, Identifiable, Hashable {
    var id = UUID()
    var time_stamp: Int64
    var text: String
}
