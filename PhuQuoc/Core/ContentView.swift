//
//  ContentView.swift
//  PhuQuoc
//
//  Created by Aleksander Pankow on 27/05/2023.
//

import SwiftUI
import FirebaseAuth

struct ContentView: View {
    
    @StateObject private var authViewModel = AuthViewModel()
    
    var body: some View {
        Group{
            if authViewModel.isUserAuthenticated {
                MainView(selectedIndex: 0)
            } else {
                WelcomeView()
            }
        }.onAppear{
            authViewModel.checkUserAuthentication()
        }

    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
