//
//  ExploreView.swift
//  PhuQuoc
//
//  Created by Aleksander Pankow on 10/06/2023.
//

import SwiftUI

struct ListingsView: View {
    
    @ObservedObject var vm = ListingViewModel()
    //ListingViewModel init
    
    @State var currrentPage = 1
    
    var body: some View {
        ScrollViewReader { scrollViewProxy in
            ScrollView{
                LazyVStack(spacing: 30){
                    ForEach(vm.listings, id: \.id) { listing in
                        CardView(listing: listing)
                            .padding(.horizontal)
                            .onAppear {
                                Task{
                                    if listing == self.vm.listings.last {
                                        currrentPage = currrentPage + 1
                                        
                                        await vm.fetchDataPage(
                                            page: currrentPage,
                                            itemsPerPage: 5,
                                            listingType:nil,
                                            searchTerm:nil,
                                            nearby:nil,
                                            latitude:nil,
                                            longitude:nil,
                                            featured:false)
                                        
                                        vm.loadingStatus = .loaded
                                        
                                        if vm.totalPages <= 0 { print("Dont have more content") }
                                    }
                                }
                                print(vm.loadingStatus)
                            }
                    }
                    if vm.totalPages <= 0 {
                        VStack{
                            Text("Dont have more content")
                                .padding(.bottom)
                            Spacer()
                        }
                        .frame(height: 180.0)
                    }
                }
                .padding(.top, 50)

            }
            .onAppear {
                Task{
                    await vm.fetchDataPage(
                        page: currrentPage,
                        itemsPerPage: 5,
                        listingType:nil,
                        searchTerm:nil,
                        nearby:nil,
                        latitude:nil,
                        longitude:nil,
                        featured:false)
                }
            }
        }
    }
}

struct ListingView_Previews: PreviewProvider {
    static var previews: some View {
        ListingsView()
    }
}
