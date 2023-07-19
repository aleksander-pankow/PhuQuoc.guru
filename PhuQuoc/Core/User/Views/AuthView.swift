//
//  LoginView.swift
//  PhuQuoc
//
//  Created by Aleksander Pankow on 25/06/2023.
//

import SwiftUI
import FirebaseAuth

struct AuthView: View {
    
    @StateObject private var authViewModel = AuthViewModel()
    
    @State private var email = ""
    @State private var password = ""
    
    @State private var action = "login" // action track

    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ZStack{
            Color(.gray)
                .opacity(0.1)
            VStack(alignment: .center, spacing: 20){
                Text(action == "login" ? "Sign In" : "Login")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                TextField("E-mail", text: $email)
                    .padding(20)
                    .background(.white)
                    .cornerRadius(15)
                SecureField("Password", text: $password)
                    .padding(20)
                    .background(.white)
                    .cornerRadius(15)
                RoundedButton(
                    text: action == "login" ? "Sign In" : "Login",
                    bgColor: Color("PrimaryBlue"),
                    textColor: .white
                ) {
                    action == "login" ?
                        authViewModel.login(email: email, password: password) :
                        authViewModel.register(email: email, password: password)
                    withAnimation(.easeInOut){
                        authViewModel.showError = true
                        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                            withAnimation(.easeInOut){
                                authViewModel.showError = false
                            }
                        }
                    }
                }
                Button {
                    action = action == "login" ? "signin" : "login"
                } label: {
                    HStack{
                        Text(action == "login" ? "Already have account?" : "New around here?")
                            .foregroundColor(Color.black)
                        Text(action == "login" ? "Login" : "Sign In")
                            .font(.headline)
                            .fontWeight(.bold)
                            .foregroundColor(Color("PrimaryBlue"))
                    }
                }

            }
            .padding()
            
            Spacer()
            
            if authViewModel.showError {
                Section{
                    Text(authViewModel.message)
                        .fontWeight(.bold)
                        .transition(.opacity)
                        .foregroundColor(.white)
                        .padding()
                        .background(.red)
                }
                .cornerRadius(15)
                .padding()
                .offset(y:100)
                
            }
        }.edgesIgnoringSafeArea(.all)
    }
    
    
}

struct AuthView_Previews: PreviewProvider {
    static var previews: some View {
        AuthView()
    }
}

//MARK: - VIEW COMPONENTS
extension AuthView{
    
}
