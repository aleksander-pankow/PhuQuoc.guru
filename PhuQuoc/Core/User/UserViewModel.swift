//
//  UserViewModel.swift
//  PhuQuoc
//
//  Created by Aleksander Pankow on 29/06/2023.
//

import Firebase
import FirebaseAuth
import FirebaseFirestore
import FirebaseFirestoreSwift

protocol UserHandlerProtocol{
    func createUser(email:String, password: String) // create user function
    func deleteUser() // delete user function
    func authUser(email:String, password: String) // auth user function
    func checkUserAuthentication() // auth cheker function
    func signOutUser() // logout function
    func updateUserData(name: String) // update user information function
    func fetchCurrentUserInfo()
}

class UserViewModel: ObservableObject, UserHandlerProtocol{
    
    init() {
        fetchCurrentUserInfo()
    }
    
    //MARK: - UserViewModel
    
    @Published var currentUser: User? // current Firestore user information object
    @Published var isUserAuthenticated = false // auth status: true/false
    @Published var message: String = "" // status message: error or success
    @Published var showError: Bool = false // show error modal controller: true/false
    @Published var user = Auth.auth().currentUser // current Firebase loged user
    
    private var listener: ListenerRegistration? // observe changes
    private let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest() // Firebase user change request function
    
    /// Mock User Data
    @Published var testUser = User(
        name: "Aleksander",
        birth: Date(timeIntervalSinceNow: 7200),
        coupons: [],
        favorite: [],
        gender: "Male",
        photo: "",
        phone: "",
        visits: []
    )
    
    // Auth cheker function
    func checkUserAuthentication() {
        Auth.auth().addStateDidChangeListener { [weak self] (auth, user) in
            self?.isUserAuthenticated = user != nil
        }
    }
    
    // Create user function
    func createUser(email: String, password: String) {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if error != nil { //error check
                print(error!.localizedDescription)
                self.message = error!.localizedDescription
            }
        }
    }
    
    // Logout user function
    func signOutUser() {
        do {
            try Auth.auth().signOut()
            isUserAuthenticated = false
        } catch {
            print("Sign out error: \(error.localizedDescription)")
            self.message = error.localizedDescription
        }
    }
    
    // Delete user function
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
    
    // Auth user function
    func authUser(email:String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if error != nil{
                print(error!.localizedDescription)
                self.message = error!.localizedDescription
            }
        }
    }
    
    // Update user function
    func updateUserData(name:String) {
        let data: [String: Any] = [
            "name": name
            // Add other fields as needed
        ]
        
        //        currentUserInformation.updateData(data) { error in
        //            if let error = error {
        //                print("Error updating document: \(error.localizedDescription)")
        //            } else {
        //                print("Document updated successfully")
        //            }
        //        }
    }
    
    func fetchCurrentUserInfo() {
        let db = Firestore.firestore()
        db.collection("user").whereField("ownerId", isEqualTo: Auth.auth().currentUser!.uid)
            .getDocuments { (snapshot, error) in
                if let error = error {
                    print("Error getting documents: \(error)")
                } else {
                    guard let documents = snapshot?.documents else {
                        print("No documents found.")
                        return
                    }
                    if let document = documents.first {
                        let data = document.data()
                        self.currentUser = User(
                            name: data["name"] as! String,
                            birth: nil,
                            coupons: nil,
                            favorite: nil,
                            gender: nil,
                            photo: nil,
                            phone: nil,
                            visits: nil
                        )
                    }
                
                }
            }
    }
    
}
