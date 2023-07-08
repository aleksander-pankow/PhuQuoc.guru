//
//  HomeView.swift
//  PhuQuoc
//
//  Created by Aleksander Pankow on 27/05/2023.
//

import SwiftUI

struct HomeView: View {
    
    @ObservedObject var vm = ListingViewModel()
    
    @State private var searchText = ""
    @State private var showingSheet = false
    @State private var activeIndex = 0
    
    let activityCategories: [String] = ["🏖️Beaches", "🦐Food", "🤿Snorkeling", "🏞️Parks", "🛥️Activity", "🏺Culture", "🎣Fishing", "🛒Markets", "🎡Hopping"]
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false){
            header
            categories
            favorited
            inspirations
        }
        .padding()
        .onTapGesture {
            self.hideKeyboard()
        }
    }
    
    
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

//MARK: - VIEW COMPONENTS

extension HomeView {
    private var header: some View{
        Section{
            HStack(spacing:30){
                HStack{
                    VStack(alignment: .leading, spacing: 5.0){
                        Text("Hi Alex,")
                            .font(.title)
                        HStack{
                            Image("navigation")
                                .resizable()
                                .renderingMode(.template)
                                .foregroundColor(Color("primaryBlue"))
                                .frame(width: 20.0, height: 20.0)
                            Text("Phu Quoc, Vietnam")
                        }
                        .opacity(0.5)
                    }
                }
                Spacer()
                NavigationLink(destination: ProfileView()){
                    Image("ava")
                        .resizable()
                        .frame(width: 65.0, height: 65.0)
                        .cornerRadius(20)
                }
            }
            .padding(.vertical)
        }
        .padding(.top, 40)
    }
    private var categories: some View{
        Section{
            HStack{
                VStack(alignment: .leading){
                    Text("Where do you")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    Text("wanna go?")
                        .font(.largeTitle)
                }
                Spacer()
            }
            ScrollViewReader { proxy in
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(alignment: .top, spacing: 15.0){
                        ForEach(vm.favoriteCategories, id: \.id) { category in
                            VStack(alignment: .center, spacing:10){
                                Text(String(category.title))
                                    .foregroundColor(
                                        category.id == activeIndex ?
                                        Color.white :
                                            Color.gray
                                    )
                            }
                            .padding([.top, .bottom], 15)
                            .padding([.leading, .trailing], 20)
                            .background(
                                category.id == activeIndex ?
                                Color.blue :
                                    Color.white
                            )
                            .overlay(RoundedRectangle(cornerRadius: 20, style: .continuous).stroke(lineWidth: 0.5).fill(.black.opacity(0.5)))
                            .cornerRadius(20)
                            .shadow(
                                color: .blue.opacity(
                                    category.id == activeIndex ? 0.2 : 0
                                ),
                                radius: 5,
                                x: 0,
                                y: 5
                            )
                            .id(category)
                            .onTapGesture{
                                withAnimation{
                                    proxy.scrollTo(category, anchor: .center)
                                    activeIndex = category.id
                                }
                            }
                            .onAppear{
                                activeIndex = category.id
                            }
                        }
                        .frame(height: 80.0)
                    }
                }
                
            }
        }
    }
    private var favorited: some View{
        Section{
            VStack{
                HStack{
                    HStack{
                        Text("Must")
                            .font(.title2)
                            .fontWeight(.bold)
                        Text("See & Do")
                            .font(.title2)
                            .fontWeight(.regular)
                    }
                    Spacer()
                    Text("View all")
                        .font(.headline)
                        .fontWeight(.bold)
                        .foregroundColor(Color.blue)
                }
                .padding(.top)
                ScrollView(.horizontal, showsIndicators: false){
                    HStack(spacing: 10){
                        
                        
                    }
                    .padding(.bottom)
                }
            }
        }
    }
    private var inspirations: some View{
        Section{
            VStack{
                HStack{
                    HStack{
                        Text("Travel")
                            .font(.title2)
                            .fontWeight(.bold)
                        Text("Inspiration")
                            .font(.title2)
                            .fontWeight(.regular)
                    }
                    Spacer()
                    Text("View all")
                        .font(.headline)
                        .fontWeight(.bold)
                        .foregroundColor(Color.blue)
                }
                .padding(.top)
                ScrollView(.horizontal, showsIndicators: false){
                    HStack(spacing: 10){
                        
                        
                    }
                    .padding(.bottom)
                }
                
            }
        }
    }
}
