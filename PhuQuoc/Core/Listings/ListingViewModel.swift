//
//  CategoryViewModel.swift
//  PhuQuoc
//
//  Created by Aleksander Pankow on 28/05/2023.
//

import Foundation
import SwiftUI
import Alamofire


class ListingViewModel: ObservableObject {
    
    @Published var currentPage = 0
    // current page number
    @Published var totalPages = 0
    //total pages number
    
    @Published var listings: [Listing] = []
    // array of listing
    
    @Published var loadingStatus: NetworkState = .none
    // status of network request
    
    @Published var favoriteCategories: [Category] = [
        Category(id: 1, title: "Popular", term: "", isFeatured: true),
        Category(id: 2, title: "Beach", term: "#phuquoc.guru.beach", isFeatured: false),
        Category(id: 3, title: "Food", term: "#phuquoc.guru.food", isFeatured: false),
        Category(id: 4, title: "Markets", term: "#phuquoc.guru.markets", isFeatured: false),
        Category(id: 5, title: "Snorkeling", term: "#phuquoc.guru.food", isFeatured: false),
        Category(id: 6, title: "Fishing", term: "#phuquoc.guru.food", isFeatured: false),
        Category(id: 7, title: "Parks", term: "#phuquoc.guru.food", isFeatured: false),
        Category(id: 8, title: "Events", term: "#phuquoc.guru.events", isFeatured: false),
        Category(id: 9, title: "Culture", term: "#phuquoc.guru.food", isFeatured: false)
    ]
    
    func fetchDataPage(
        page: Int,
        itemsPerPage: Int,
        listingType: Int?,
        searchTerm: String?,
        nearby: String?,
        latitude: Double?,
        longitude: Double?,
        featured: Bool
    ) async {
        
        loadingStatus = .loading
        //set network request to active loading
        
        let url = "https://phuquoc.guru/wp-json/cththemes/v1/listings"
        let parameters: Parameters = [
            "paged": page,
            "posts_per_page": itemsPerPage,
            "ltype": listingType ?? "",
            "search_term": searchTerm ?? "",
            "nearby": nearby ?? "",
            "address_lat": latitude ?? "",
            "address_lng": longitude ?? "",
            "distance": 50,
        ]
        
        AF.request(url, parameters: parameters)
            .validate()
            .responseDecodable(of: JSONResponse.self) { [weak self] response in
                guard let self else { return }
                switch response.result {
                case .success(let data):
                    if featured == true {
                        self.listings += data.items.filter{ $0.isFeatured == true }
                    } else {
                        self.listings +=  data.items
                    }
                    self.totalPages = data.pages
                    
                case .failure(let error):
                    print("Error: \(error)")

                }
            }
    }
    
}

