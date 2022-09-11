//
//  Date+Extension.swift
//  ReswiftTodo
//
//  Created by iOS Developer on 9/10/22.
//

import Foundation

extension Date {
    func currentTimeMillis() -> Int64 {
        return Int64(self.timeIntervalSince1970 * 1000)
    }
}
