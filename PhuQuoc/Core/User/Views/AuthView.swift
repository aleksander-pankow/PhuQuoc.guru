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

    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ZStack(alignment: .bottom){
            VStack(spacing: 20){
                Image("logo")
                    .offset(x: -100, y: -200)
                TextField("E-mail", text: $email)
                    .padding(.bottom, 3.0)
                Rectangle()
                    .frame(height:1)
                SecureField("Password", text: $password)
                    .padding(.vertical, 3.0)
                Rectangle()
                    .frame(height:1)
                Button {
                    authViewModel.register(email: email, password: password)
                    withAnimation(.easeInOut){
                        authViewModel.showError = true
                        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                            withAnimation(.easeInOut){
                                authViewModel.showError = false
                            }
                        }
                    }
                } label: {
                    Text("Sign In")
                        .bold()
                        .frame(width: 200, height: 40)
                        .background(.black)
                        .padding(.top)
                }
                Button {
                    authViewModel.login(email: email, password: password)
                    withAnimation(.easeInOut){
                        authViewModel.showError = true
                        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                            withAnimation(.easeInOut){
                                authViewModel.showError = false
                            }
                        }
                    }
                } label: {
                    Text("Already have account? Login")
                        .padding(.top)
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
