//
//  ContentView.swift
//  PhuQuoc
//
//  Created by Aleksander Pankow on 27/05/2023.
//

import SwiftUI
import FirebaseAuth

struct ContentView: View {
    
    @StateObject private var vm = UserViewModel()
    
    var body: some View {
        test
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

//MARK: - VIEW COMPONENTS

extension ContentView {
    private var test: some View{
        MainView(selectedIndex: 0)
    }
    private var production: some View{
        Group{
            if vm.isUserAuthenticated {
                MainView(selectedIndex: 0)
            } else {
                WelcomeView()
            }
        }.onAppear{
            vm.checkUserAuthentication()
        }
    }
}
