//
//  UserViewModel.swift
//  PhuQuoc
//
//  Created by Aleksander Pankow on 29/06/2023.
//

import Foundation
import FirebaseAuth

protocol DataBasehandlerProtocol{
    func createUser(email:String, password: String)
    func deleteUser()
    func authUser(email:String, password: String)
    func updateUser()
    func checkUserAuthentication()
    func signOutUser()
}

class UserViewModel: ObservableObject, DataBasehandlerProtocol{
    
    @Published var isUserAuthenticated = false
    @Published var message: String = ""
    @Published var showError: Bool = false
    
    @Published var user = Auth.auth().currentUser
    
    func checkUserAuthentication() {
        Auth.auth().addStateDidChangeListener { [weak self] (auth, user) in
            self?.isUserAuthenticated = user != nil
        }
    }
    
    func createUser(email: String, password: String) {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if error != nil {
                print(error!.localizedDescription)
                self.message = error!.localizedDescription
            }
        }
    }
    
    func signOutUser() {
        do {
            try Auth.auth().signOut()
            isUserAuthenticated = false
        } catch {
            print("Sign out error: \(error.localizedDescription)")
            self.message = error.localizedDescription
        }
    }
    
    func deleteUser() {
        guard self.user != nil else { return }
        
        self.user!.delete { error in
            if let error = error {
                print(error)
            } else {
                print("Account deleted.")
                // Account deleted.
            }
        }
    }
    
    func authUser(email:String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if error != nil{
                print(error!.localizedDescription)
                self.message = error!.localizedDescription
            }
        }
    }
    
    func updateUser() {
        
    }
    
    
}
