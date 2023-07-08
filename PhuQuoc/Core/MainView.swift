//
//  MainView.swift
//  PhuQuoc
//
//  Created by Aleksander Pankow on 25/06/2023.
//

import SwiftUI
import FirebaseAuth

struct MainView: View {
    
    let tabbarItems = [ "Home", "Travel", "Events","Profile" ]
    @State var selectedIndex: Int
    
    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
            NavigationView{
                ZStack(alignment: .bottom){
                    TabView(selection: $selectedIndex) {
                        HomeView()
                            .tag(0)
                            .ignoresSafeArea()
                        ListingsView()
                            .tag(1)
                            .ignoresSafeArea()
                        EventsView()
                            .tag(2)
                            .ignoresSafeArea()
                        ProfileView()
                            .tag(3)
                            .ignoresSafeArea()
                    }
                    .onAppear(){
                        let transparentAppearence = UITabBarAppearance()
                        transparentAppearence.configureWithTransparentBackground()
                        UITabBar.appearance().standardAppearance = transparentAppearence
                    }
                    TabBarView(tabbarItems: tabbarItems, selectedIndex: $selectedIndex)
                        .padding(.horizontal)
                }
            }
        }
 
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(selectedIndex: 0)
    }
}
