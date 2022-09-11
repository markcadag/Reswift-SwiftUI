//
//  LoginView.swift
//  ReswiftTodo
//
//  Created by iOS Developer on 9/10/22.
//

import Foundation
import SwiftUI
import ReSwift

struct RegistrationView: View {
    @ObservedObject private var navigationState = ObservableState<NavigationState>(store: navigationStore)
    
    @EnvironmentObject private var authenticationState: ObservableAuthState
    
    @Environment(\.managedObjectContext) var managedObjectContext
    
    @Environment(\.presentationMode) var presentationMode

    let lightGreyColor = Color(red: 239.0/255.0, green: 243.0/255.0, blue: 244.0/255.0, opacity: 1.0)

    
    var alert: Alert {
        Alert(title: Text("Hey!"),
              message: Text(authenticationState.current.errorString ?? ""))
    }
    
    
    var body: some View {
        ZStack{
            Color.white.ignoresSafeArea()
            
            VStack(spacing: 10){
                
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
                 .background(lightGreyColor)
                 .cornerRadius(5.0)
                 .foregroundColor(.black)
                 .padding(.bottom, 20)
                
                // SignIn
                Button(action: {
                    authenticationState.dispatch(register(context: managedObjectContext))
                }){
                    Text("REGISTER")
                }
                
                Spacer()
                // SignUp
                VStack(spacing: 10){
                    Text("Already have account?")
                    Button(action: {
                        self.presentationMode.wrappedValue.dismiss()
                    }){
                        Text("Login Now")
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

struct Registration_Previews: PreviewProvider {
    static var previews: some View {
        RegistrationView()
    }
}
