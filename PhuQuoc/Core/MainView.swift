//
//  MainView.swift
//  PhuQuoc
//
//  Created by Aleksander Pankow on 25/06/2023.
//

import SwiftUI
import FirebaseAuth

struct MainView: View {
    
    let tabbarItems = [ "Home", "Travel", "Events","Coupons" ]
    @State var selectedIndex: Int
    
    var body: some View {
            NavigationView{
                ZStack(alignment: .bottom){
                    TabView(selection: $selectedIndex) {
                        HomeView()
                            .tag(0)
                            .background(Color("PrimaryGray"))
                        ListingsView()
                            .tag(1)
                            .background(Color("PrimaryGray"))
                            .ignoresSafeArea()
                        EventsView()
                            .tag(2)
                            .background(Color("PrimaryGray"))
                            .ignoresSafeArea()
                        CouponView()
                            .tag(3)
                            .background(Color("PrimaryGray"))
                            .ignoresSafeArea()
                    }
                    .onAppear(){
                        let transparentAppearence = UITabBarAppearance()
                        transparentAppearence.configureWithTransparentBackground()
                        UITabBar.appearance().standardAppearance = transparentAppearence
                    }
                    TabBarView(tabbarItems: tabbarItems, selectedIndex: $selectedIndex)
                        .padding(.horizontal, 30)
                }
            }
        }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(selectedIndex: 0)
    }
}
