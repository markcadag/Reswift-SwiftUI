//
//  AuthenticationState.swift
//  ReswiftTodo
//
//  Created by iOS Developer on 9/11/22.
//

import Foundation
import ReSwift
import SwiftUI

struct AuthenticationState {
    var isAuthenticated: Bool?
    var email: String?
    var password: String?
    var errorString: String?
    var showAlert: Bool?
    var user: User?
}
