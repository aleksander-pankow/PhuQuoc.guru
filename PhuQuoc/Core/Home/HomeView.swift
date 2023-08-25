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
    @State var activeCategory = 0
    @State private var isFavourited = true
    
    @State var currrentPage = 1
    
    let width = UIScreen.main.bounds.width - 60
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false){
            header
            categories
            favorited
            inspirations
        }
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
            HStack{
                    NavigationLink(destination: UserView()){
                        ZStack{
                            Image("ava")
                                .resizable()
                                .clipShape(Circle())
                                .frame(width: 50.0, height: 50.0)
                                .offset(y:12)
                                .blur(radius: 5)
                            Image("ava")
                                .resizable()
                                .clipShape(Circle())
                                .overlay {
                                    Circle()
                                        .stroke(.white, lineWidth: 5)
                                }
                                .frame(width: 60.0, height: 60.0)
                        }
                    }
                Spacer()
                Text("Hello, " + (uvm.testUser.name))
                    .font(.title3)
                    .redacted(reason: uvm.testUser.name.isEmpty ? .placeholder : [])
                Spacer()
                ZStack{
                    Circle()
                        .foregroundColor(.gray.opacity(0.1))
                        .frame(width: 55.0, height: 55.0)
                    Circle()
                        .foregroundColor(.white)
                        .frame(width: 45.0, height: 45.0)
                        .shadow(color:Color("PrimaryBlue").opacity(0.1),radius: 2.0, y:3)
                    Image("Bell")
                        .renderingMode(.template)
                        .resizable()
                        .frame(width: 25.0, height: 25.0)
                        .shadow(color:Color("PrimaryBlue").opacity(0.4),radius: 2.0, y:2)
                        .foregroundColor(Color("PrimaryBlue"))
                        .padding(10)
                        .background(.white)
                        .clipShape(Circle())
                        .overlay {
                            Text("0")
                                .font(.caption2)
                                .padding(1)
                                .foregroundColor(.white)
                                .background(.red)
                                .cornerRadius(10)
                                .offset(x:5.0,y:-8.0)
                                
                        }
                }
            }
        }
        .padding(.horizontal, 30)
        .padding(.vertical)
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
                .padding(.horizontal, 30)
                Spacer()
            }
            VStack(spacing: 10.0){
                HStack{
                    Text("Categories")
                        .font(.title2)
                        .fontWeight(.bold)
                    Spacer()
                }
                .padding(.horizontal, 30)
                ScrollViewReader { proxy in
                    ScrollView(.horizontal, showsIndicators: false) {
                        LazyHStack(alignment: .center, spacing: 15.0){
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
                                            .opacity(category.id == vm.activeCategoryIndex ?
                                                     1.0 :
                                                        0.3)
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
                                        Task{
                                            await vm.fetchDataPage(
                                                page: currrentPage,
                                                itemsPerPage: 10,
                                                listingType:category.lcat,
                                                searchTerm:nil,
                                                nearby:nil,
                                                latitude:nil,
                                                longitude:nil,
                                                fetchMode: FetchMode.category,
                                                featured:true)
                                        }
                                    }
                                    
                                }
                                .id(category)
                            }
                            .frame(height: 80.0)
                            
                        }
                        .padding(.horizontal, 30)
                        
                    }
                    ScrollView(.horizontal, showsIndicators: false){
                        LazyHStack(alignment: .center, spacing: 30.0){
                            ForEach(vm.listings, id: \.id) { listing in
                                CardView(listing: listing, width: width)
                            }
                        }
                        .padding(.horizontal, 30)
                    }
                    .onAppear {
                        Task{
                            await vm.fetchDataPage(
                                page: currrentPage,
                                itemsPerPage: 10,
                                listingType:nil,
                                searchTerm:nil,
                                nearby:nil,
                                latitude:nil,
                                longitude:nil,
                                fetchMode: FetchMode.infinity,
                                featured:true)
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
                .padding(.horizontal, 30)
                ScrollView(.horizontal, showsIndicators: false){
                    LazyHStack(spacing: 10){
                        
                        
                    }
                    .padding(.horizontal, 30)
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
                .padding(.horizontal, 30)
                ScrollView(.horizontal, showsIndicators: false){
                    LazyHStack(spacing: 10){
                        
                        
                    }
                    .padding(.bottom)
                    .padding(.horizontal, 30)
                }
                
            }
        }
    }
}
