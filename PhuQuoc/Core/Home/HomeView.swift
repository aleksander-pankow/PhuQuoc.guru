//
//  HomeView.swift
//  PhuQuoc
//
//  Created by Aleksander Pankow on 27/05/2023.
//

import SwiftUI

struct HomeView: View {
    
    @ObservedObject var vm = ListingViewModel()
    @StateObject var uvm = UserViewModel()
    
    @State private var searchText = ""
    @State private var showingSheet = false
    @State private var isPresented = true
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false){
            header
            categories
            favorited
            inspirations
        }
        .padding(.horizontal, 30)
        .onTapGesture {
            self.hideKeyboard()
        }
        .onAppear{
            print(vm.activeCategoryIndex)
        }
        //        .popup(isPresented: $isPresented) {
        //            BottomPopupView {
        //                UserProfileStartView(isPresented: $isPresented)
        //            }
        //        }
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
                        HStack{
                            NavigationLink(destination: UserView()){
                                    Image("ava")
                                        .resizable()
                                        .clipShape(Circle())
                                        .overlay {
                                            Circle()
                                                .stroke(.gray, lineWidth: 5)
                                                .shadow(color: .black.opacity(0.3), radius: 3, x: 0, y: 3)
                                        }
                                        .frame(width: 50.0, height: 50.0)
                                        .edgesIgnoringSafeArea(.all)

                            }
                            Text("Hello " + (uvm.testUser.name))
                                .font(.title3)
                                .redacted(reason: uvm.testUser.name.isEmpty ? .placeholder : [])
                        }
                    }
                }
                Spacer()
                NavigationLink(destination: UserView()){
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
            VStack(spacing: 10.0){
                HStack{
                    Text("Categories")
                        .font(.title2)
                        .fontWeight(.bold)
                    Spacer()
                }
                ScrollViewReader { proxy in
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(alignment: .center, spacing: 15.0){
                            ForEach(vm.favoriteCategories, id: \.id) { category in
                                VStack(alignment: .center, spacing:10){
                                    HStack(spacing: 20.0){
                                        ZStack{
                                            Text(String(category.title.prefix(1)))
                                                .blur(radius: 2)
                                                .offset(y: 3)
                                            Text(String(category.title.prefix(1)))
                                                
                                        }
                                        .padding(10)
                                        .background(Color("SecondaryGray"))
                                        .overlay(RoundedRectangle(cornerRadius: 10, style: .continuous).stroke(lineWidth: 2).fill(.gray.opacity(0.05)))
                                            .cornerRadius(10)
                                        Text(String(category.title.dropFirst()))
                                            .padding(.trailing, 10)
                                            .foregroundColor(
                                                category.id == vm.activeCategoryIndex ?
                                                Color.black :
                                                    Color.gray
                                            )
                                    }
                                }
                                .padding(10)
                                .background(
                                    category.id == vm.activeCategoryIndex ?
                                    Color.white :
                                        nil
                                )
                                .overlay(RoundedRectangle(cornerRadius: 20, style: .continuous).stroke(lineWidth: 2).fill(
                                    category.id == vm.activeCategoryIndex ? .white : .gray.opacity(0.1))
                                )
                                .cornerRadius(20)
                                .shadow(
                                    color: .gray.opacity(
                                        category.id == vm.activeCategoryIndex ? 0.08 : 0
                                    ),
                                    radius: 5,
                                    x: 0,
                                    y: 5
                                )
                                .onTapGesture{
                                    withAnimation{
                                        vm.activeCategoryIndex = category.id
                                        proxy.scrollTo(category, anchor: .center)
                                    }
                                }
                                .id(category)
                            }
                            .frame(height: 80.0)
                        }
                    }
                    
                }
            }
            .padding(.top)
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
                        .foregroundColor(Color("PrimaryBlue"))
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
                        .foregroundColor(Color("PrimaryBlue"))
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
