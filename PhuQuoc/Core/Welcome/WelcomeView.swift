//
//  WelcomeView.swift
//  PhuQuoc
//
//  Created by Aleksander Pankow on 25/06/2023.
//

import SwiftUI
import SwiftUIX

struct WelcomeView: View {
    
    @State private var isSheetPresented = false
    @State var userIsLoggedIn = false
    
    var body: some View {
        ZStack(alignment:.bottom){
            background
            Spacer()
            content
        }
        .ignoresSafeArea(.all)
        .sheet(isPresented: $isSheetPresented){
            AuthView()
        }
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}

//MARK: - VIEW COMPONENTS
extension WelcomeView{
    private var background: some View{
        Group{
            Image("welcome")
                .resizable()
                .scaledToFill()
            
            LinearGradient(colors: [
                Color.white.opacity(0),
                Color("PrimaryBlue").opacity(0.6)
            ], startPoint: .top, endPoint: .bottom)
        }
        
    }
    private var content: some View{
        VStack{
            VStack(alignment: .leading, spacing: 50.0){
                Text("Explore the Best Places in Phu Quoc: Unveiling the Island's Hidden Gems!")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(Color.white)
                RoundedButton(
                    text: "Start"
                ) {
                    isSheetPresented = true
                }
                
            }
        }
        .padding(.horizontal, 40)
        .padding(.bottom, 40)
    }
}
