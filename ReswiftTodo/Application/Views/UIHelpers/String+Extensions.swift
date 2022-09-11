//
//  String+Extensions.swift
//  ReswiftTodo
//
//  Created by iOS Developer on 9/11/22.
//

import Foundation

extension Optional where Wrapped == String {
    var isBlank: Bool {
        return self?.isEmpty ?? true
    }
    
    func isValidEmail() -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: self)
    }
    
}
