//
//  ImageSlider.swift
//  PhuQuoc
//
//  Created by Aleksander Pankow on 23/06/2023.
//

import SwiftUI

struct ImageSlider: View {
    
    @State var images: [Photos]
    @State var listing: Listing
    
    var body: some View {
        TabView {
            if images.count > 0 {
                ForEach(images.indices, id: \.self) { item in
                    AsyncImage(url: URL(string: images[item].src.replacingOccurrences(of: "http://", with: "https://")), transaction: .init(animation: .easeOut)) { phase in
                        switch phase {
                        case .empty:
                            ProgressView()
                        case .success(let image):
                            image
                                .resizable()
                                .scaledToFill()
                        case .failure(_):
                            Color.gray
                        @unknown default:
                            Color.gray
                        }
                    }
                    .mask(RoundedRectangle(cornerRadius: 25, style: .continuous))
                    .edgesIgnoringSafeArea(.all)
                    
                }
            } else {
                AsyncImage(url: URL(string: listing.thumbnail), transaction: .init(animation: .easeOut)) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFill()
                    case .failure(_):
                        Color.gray
                    @unknown default:
                        Color.gray
                    }
                }
                .mask(RoundedRectangle(cornerRadius: 25, style: .continuous))
                .edgesIgnoringSafeArea(.all)
            }
        }
        .tabViewStyle(PageTabViewStyle())
        
    }
}

struct ImageSlider_Previews: PreviewProvider {
    static var previews: some View {
        let images: [Photos] = [
            Photos(title: "", src: "https://picsum.photos/800"),
            Photos(title: "", src: "https://picsum.photos/800"),
            Photos(title: "", src: "https://picsum.photos/800")
        ]
        let listing = Listing(id: 1, rating: Rating(base: 4, rating: 4, count: 5, countText: "3"), address: "Adress", latitude: 40.7, longitude: -73.87, url: "https://phuquoc.guru", title: "City Street Coffee", content: "Test content", excerpt: "Test excerpt", price: 300, thumbnail: "https://picsum.photos/200", photos: [Photos(title: "", src: "https://picsum.photos/800"),Photos(title: "", src: "https://picsum.photos/800"),Photos(title: "", src: "https://picsum.photos/800")], distance: "1", distanceWithUnit: "3", isFeatured: true, authorID: "4", authorName: "Alex", viewCount: 123)
        ImageSlider(images: images, listing: listing)
    }
}
