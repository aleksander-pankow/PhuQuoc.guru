//
//  LoginView.swift
//  PhuQuoc
//
//  Created by Aleksander Pankow on 25/06/2023.
//

import SwiftUI
import FirebaseAuth

struct AuthView: View {
    
    @StateObject private var userViewModel = UserViewModel()
    
    @State private var email = ""
    @State private var password = ""
    
    @State private var action = "signin" // action track

    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ZStack{
            
            VStack(alignment: .center){
                Image("login")
                    .resizable()
                    .scaledToFill()
                    .frame(height: 300)
                    .mask{
                        Circle()
                            .frame(width:800, height: 800)
                    }
                    .cornerRadius([.bottomLeading, .bottomTrailing], 100)
                Spacer()
                VStack(spacing: 20){
                    Text(action == "login" ? "Login" : "Sign In")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    
                    TextField("E-mail", text: $email)
                        .padding(20)
                        .background(.white)
                        .cornerRadius(15)
                        .shadow(color: Color.black.opacity(0.05), radius: 15, x: 0, y: 10)
                    SecureField("Password", text: $password)
                        .padding(20)
                        .background(.white)
                        .cornerRadius(15)
                        .shadow(color: Color.black.opacity(0.05), radius: 15, x: 0, y: 10)
                    RoundedButton(
                        text: action == "login" ? "Login" : "Sign In",
                        bgColor: Color("PrimaryBlue"),
                        textColor: .white
                    ) {
                        action == "login" ?
                        userViewModel.authUser(email: email, password: password) :
                        userViewModel.createUser(email: email, password: password)
                        withAnimation(.easeInOut){
                            userViewModel.showError = true
                            DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                                withAnimation(.easeInOut){
                                    userViewModel.showError = false
                                }
                            }
                        }
                    }
                    Button {
                        action = action == "login" ? "signin" : "login"
                    } label: {
                        HStack{
                            Text(action == "login" ? "New around here?" : "Already have account?")
                                .foregroundColor(Color.black)
                            Text(action == "login" ? "Sign In" : "Login")
                                .font(.headline)
                                .fontWeight(.bold)
                                .foregroundColor(Color("PrimaryBlue"))
                        }
                    }
                }
                .padding()
                Spacer()

            }
            //.padding()
            
            Spacer()
            
            if userViewModel.showError {
                Section{
                    Text(userViewModel.message)
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
