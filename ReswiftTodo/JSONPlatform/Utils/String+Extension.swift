//
//  String+Extension.swift
//  ReswiftTodo
//
//  Created by iOS Developer on 9/10/22.
//

import Foundation

extension String {
    func sha256(salt: String) -> Data {
        return (self + salt).data(using: .utf8)!.sha256
    }
}
