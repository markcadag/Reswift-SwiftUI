//
//  Int64+Extension.swift
//  ReswiftTodo
//
//  Created by iOS Developer on 9/10/22.
//
import Foundation

extension Int64 {
    func toFormattedDate() -> String {
        let date = NSDate(timeIntervalSince1970: Double(self) / 1000)
         let dayTimePeriodFormatter = DateFormatter()
         dayTimePeriodFormatter.dateFormat = "dd MMM YY, hh:mm a"
         let dateString = dayTimePeriodFormatter.string(from: date as Date)
         return dateString
    }
}
