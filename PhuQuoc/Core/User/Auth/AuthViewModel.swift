//
//  AuthViewModel.swift
//  PhuQuoc
//
//  Created by Aleksander Pankow on 25/06/2023.
//

import FirebaseAuth

class AuthViewModel: ObservableObject {
    @Published var isUserAuthenticated = false
    @Published var message: String = ""
    @Published var showError: Bool = false
    

    func checkUserAuthentication() {
        Auth.auth().addStateDidChangeListener { [weak self] (auth, user) in
            self?.isUserAuthenticated = user != nil
        }
    }
    
    func login(email:String, password: String){
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if error != nil{
                print(error!.localizedDescription)
                self.message = error!.localizedDescription
            }
        }
    }
    
    func signOut() {
        do {
            try Auth.auth().signOut()
            isUserAuthenticated = false
        } catch {
            print("Sign out error: \(error.localizedDescription)")
            self.message = error.localizedDescription
        }
    }
        
    
    func register(email:String, password: String){
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if error != nil {
                print(error!.localizedDescription)
                self.message = error!.localizedDescription
            }
        }
    }
    
    
}
