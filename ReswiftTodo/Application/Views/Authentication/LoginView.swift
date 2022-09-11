//
//  LoginView.swift
//  ReswiftTodo
//
//  Created by iOS Developer on 9/10/22.
//

import Foundation
import SwiftUI
import ReSwift

struct LoginView: View {
    

    @ObservedObject private var navigationState = ObservableState<NavigationState>(store: navigationStore)
    @EnvironmentObject private var authenticationState: ObservableAuthState
    
    @Environment(\.managedObjectContext) var managedObjectContext
    
    var alert: Alert {
        Alert(title: Text("Hey!"),
              message: Text(authenticationState.current.errorString ?? ""))
    }
    
    let lightGreyColor = Color(red: 239.0/255.0, green: 243.0/255.0, blue: 244.0/255.0, opacity: 1.0)

    
    var body: some View {
        ZStack{
            Color.white.ignoresSafeArea()
            
            VStack(spacing: 10) {
                TextField("Email", text: Binding(
                    get: { authenticationState.current.email ?? "" },
                    set: { value in
                        authenticationState.dispatch(AuthenticationAction.email(email: value))
                    }
                    ))
                 .foregroundColor(.black)
                 .autocapitalization(.none)
                 .padding()
                 .background(lightGreyColor)
                 .cornerRadius(5.0)
                 .padding(.bottom, 20)
                
                 SecureField("Password", text: Binding(
                    get: { authenticationState.current.password ?? "" },
                    set: { value in
                        authenticationState.dispatch(AuthenticationAction.password(password: value))
                    }
                 )).padding()
                 .foregroundColor(.black)
                 .background(lightGreyColor)
                 .cornerRadius(5.0)
                 .padding(.bottom, 20)
                
                // SignIn
                Button(action: {
                    authenticationState.dispatch(signIn(context: managedObjectContext))
                }){
                    Text("SIGN IN")
                }
                
                Spacer()
                // SignUp
                VStack(spacing: 10){
                    Text("Don't have an account?")
                    Button(action: {
                        navigationState.dispatch(NavigationAction.navigate(tagName: NavigationTag.registrationView.rawValue))
                    }){
                        Text("Sign Up")
                    }
                }
            }.alert(isPresented: Binding(
                get: { authenticationState.current.showAlert ?? false },
                set: { value in
                    authenticationState.dispatch(AuthenticationAction.showAlert(show: value))
                }
            ) , content: {
                alert
            })
            .padding(.horizontal,30)
            .padding(.vertical, 25)
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
