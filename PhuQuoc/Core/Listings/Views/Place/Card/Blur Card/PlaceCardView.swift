//
//  ExploreCardView.swift
//  PhuQuoc
//
//  Created by Aleksander Pankow on 10/06/2023.
//

import SwiftUI
import SwiftUIX

struct PlaceCardView: View {
    
    let listing: Listing
    let navigation = NavigationManager()
    @State private var isSheetPresented = false
    
    var body: some View {
        ZStack(alignment: .top){
            ZStack(alignment: .bottom){
                background
                content
            }.frame(height: 350.0)
            title
        }
        .sheet(isPresented: $isSheetPresented){
            PlaceView(listing: listing)
        }
    }
    var title: some View{
        HStack(alignment: .center) {
            
            Text(listing.title)
                .font(.title2)
                .fontWeight(.medium)
                .foregroundColor(Color.black)
                .lineLimit(2)
            
            Image(listing.isFeatured ? "award" : "")
                .resizable()
                .renderingMode(.template)
                .foregroundColor(.black)
                .frame(
                    width: listing.isFeatured ? 20.0 : 0,
                    height: listing.isFeatured ? 20.0 : 0
                )
            
        }.padding(.top, 30)
    }
    var background: some View{
        ZStack{
            
            AsyncImage(url: URL(string: listing.thumbnail), transaction: .init(animation: .easeOut)) { phase in
                switch phase {
                case .empty:
                    Color.white
                case .success(let image):
                    image
                        .resizable()
                case .failure(_):
                    Color.gray
                @unknown default:
                    Color.gray
                }
            }
            .mask(RoundedRectangle(cornerRadius: 30, style: .continuous))
            .padding([.bottom], 70)
            
            Blur(style: .light)
                .mask(RoundedRectangle(cornerRadius: 30, style: .continuous))
                .padding([.bottom], 70)
            
            AsyncImage(url: URL(string: listing.thumbnail), transaction: .init(animation: .easeOut)) { phase in
                switch phase {
                case .empty:
                    Color.white
                case .success(let image):
                    image
                        .resizable()
                case .failure(_):
                    Color.gray
                @unknown default:
                    Color.gray
                }
            }
            .mask(RoundedRectangle(cornerRadius: 30, style: .continuous))
            .padding([.bottom], 70)
            .mask(LinearGradient(colors: [Color.white, Color.white.opacity(0)], startPoint: .bottom, endPoint: .top))
        }
        
    }
    var content: some View{
        VStack{
            HStack(alignment: .center){
                VStack(alignment: .leading){
                    
                    Section{
                        Text("Praesent eros turpis, commodo vel justo at, pulvinar mollis eros. Mauris aliquet eu quam id ornare. Morbi ac quam enim. Cras vitae nulla condimentum, semper dolor non, faucibus dolor.")
                            .font(.headline)
                            .fontWeight(.light)
                            .foregroundColor(Color.black)
                            .lineLimit(2)
                            .padding(.all)
                    }
                    
                    Spacer()
                    
                    Section{
                        HStack{
                            
                            VStack(alignment: .leading){
                                Text("Type")
                                    .font(.footnote)
                                    .fontWeight(.bold)
                                    .opacity(0.4)
                                Text("Bar")
                                    .fontWeight(.bold)
                                
                            }
                            
                            Spacer()
                            
                            VStack(alignment: .leading){
                                
                                Text("Price")
                                    .font(.footnote)
                                    .fontWeight(.bold)
                                    .opacity(0.4)
                                
                                Text("$$")
                                    .fontWeight(.bold)
                                
                            }
                            Spacer()
                            VStack(alignment: .leading){
                                Text("Rating")
                                    .font(.footnote)
                                    .fontWeight(.bold)
                                    .opacity(0.4)
                                Text("4.6")
                                    .fontWeight(.bold)
                            }
                        }
                        .padding(.horizontal)
                    }
                    
                    Spacer()
                    
                    Section{
                        HStack(alignment: .center){
                            HStack(spacing:5){
                                
                                Button(action: {
                                    isSheetPresented = true
                                    print("Info open!")
                                }) {
                                    Image("info")
                                        .resizable()
                                        .foregroundColor(Color.white)
                                        .frame(width: 15, height: 15)
                                        .padding([.horizontal], 10)
                                        .padding([.vertical], 15)
                                }
                                
                                Divider()
                                    .frame(height: 20.0)
                                
                                Button(action: {
                                    navigation.moveTo(
                                        latitude: listing.latitude,
                                        longitude: listing.longitude,
                                        title: listing.title
                                    )
                                    print("Navigation tapped!")
                                }) {
                                    Image("navigation")
                                        .resizable()
                                        .foregroundColor(Color.white)
                                        .frame(width: 15, height: 15)
                                        .padding([.horizontal], 10)
                                        .padding([.vertical], 15)
                                }
                                
                                Divider()
                                    .frame(height: 20.0)
                                
                                Button(action: {
                                    // Handle image tap action here
                                    print("Image tapped!")
                                }) {
                                    Image("star")
                                        .resizable()
                                        .foregroundColor(Color.white)
                                        .frame(width: 15, height: 15)
                                        .padding([.horizontal], 10)
                                        .padding([.vertical], 15)
                                }
                                
                            }
                            .padding(.horizontal, 10)
                            .background(Blur(style: .systemUltraThinMaterialLight))
                            .mask(RoundedRectangle(cornerRadius: 15, style: .continuous))
                            .overlay(RoundedRectangle(cornerRadius: 15, style: .continuous).stroke(lineWidth: 0.5).fill(.white.opacity(0.5)))
                            //.offset(x: -20, y: 15)
                            
                            Spacer()
                            
                            HStack{
                                
                                ShareLink(item: "https://google.com", preview: SharePreview("\(listing.title) - Phu Quoc Guru", image: listing.thumbnail)){
                                    Image("share")
                                        .resizable()
                                        .foregroundColor(Color.white)
                                        .frame(width: 15, height: 15)
                                        .padding([.horizontal], 10)
                                        .padding([.vertical], 15)
                                }
                                
                            }
                            .padding(.horizontal, 10)
                            .background(Blur(style: .systemUltraThinMaterialLight))
                            .mask(RoundedRectangle(cornerRadius: 15, style: .continuous))
                            .overlay(RoundedRectangle(cornerRadius: 15, style: .continuous).stroke(lineWidth: 0.5).fill(.white.opacity(0.5)))
                                
                        }
                    }
                }
            }
        }
        .frame(height: 180)
        .background(Blur(style: .systemUltraThinMaterial))
        .mask(RoundedRectangle(cornerRadius: 20, style: .continuous))
        .overlay(RoundedRectangle(cornerRadius: 20, style: .continuous).stroke(lineWidth: 0.5).fill(.white.opacity(0.5)))
        .shadow(color: .black.opacity(0.3), radius: 25, x: 0, y: 0)
        .padding(25)
        .offset(y:-15)
    }
    
    
}

struct PlaceCardView_Previews: PreviewProvider {
    static var previews: some View {
        let listing = Listing(id: 1, rating: Rating(base: 4, rating: 4, count: 5, countText: "3"), address: "Adress", latitude: 40.7, longitude: -73.87, url: "https://phuquoc.guru", title: "City Street Coffee", content: "Test content", excerpt: "Test excerpt", price: 300, thumbnail: "https://picsum.photos/800", photos: [Photos(title: "", src: "https://picsum.photos/800"),Photos(title: "", src: "https://picsum.photos/800"),Photos(title: "", src: "https://picsum.photos/800")], distance: "1", distanceWithUnit: "3", isFeatured: true, authorID: "4", authorName: "Alex", viewCount: 123)
        PlaceCardView(listing: listing)
    }
}
