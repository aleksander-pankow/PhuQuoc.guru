//
//  PlaceView.swift
//  PhuQuoc
//
//  Created by Aleksander Pankow on 20/06/2023.
//

import SwiftUI
import MapKit

struct PlaceView: View {
    
    @Environment(\.dismiss) var dismiss
    
    let listing: Listing
    let navigation = NavigationManager()

    @State private var currentPage: Int = 0
    
    var body: some View {
        ZStack(alignment:.bottom){
            Color.clear
            VStack{
                ScrollView(.vertical){
                    background
                    header
                    map
                    content
                    Spacer()
                    
                }
                
                
            }
            Spacer()
            floatPanel
        }
        .edgesIgnoringSafeArea(.all)
    }
    var background: some View{
        ZStack(alignment: .top){
            NavigationView {
                List {
                    ImageSlider(images: listing.photos, listing: listing)
                        .frame(height: 250)
                        .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                        .cornerRadius(15)
                }
                .listStyle(PlainListStyle())
                .listRowBackground(Color.white)
                .background(Color.white)
            }
            .frame(height: 250.0)
            .mask(RoundedRectangle(cornerRadius: 25, style: .continuous))
        }
        .frame(height: 250)
        .offset(y: -20)
    }
    var header: some View{
        Section{
            HStack{
                VStack(alignment: .leading, spacing: 5){
                    HStack{
                        Text(listing.title)
                            .font(.title2)
                            .fontWeight(.bold)
                        Image(listing.isFeatured ? "award" : "")
                            .resizable()
                            .renderingMode(.template)
                            .foregroundColor(Color("primaryBlue"))
                            .frame(width: 20.0, height: 20.0)
                    }
                    Text(listing.address)
                        .font(.footnote)
                        .foregroundColor(Color.gray)
                }
                Spacer()
                HStack{
                    Text(String(format: "%.1f", listing.rating.rating))
                        .font(.footnote)
                        .fontWeight(.medium)
                        .foregroundColor(Color.gray)
                    Image(systemName: "star.circle.fill")
                        .resizable()
                        .frame(width: 25, height: 25)
                        .foregroundColor(.yellow)
                    
                }
            }.padding()
        }
    }
    var content: some View{
        Section{
            VStack(alignment: .leading){
                Text("Description")
                    .font(.headline)
                Text(LocalizedStringKey(
                    listing.content.htmlToMarkDown()))
            }
            .padding()
        }
    }
    var map: some View{
        Section{
            VStack{
                MapView(coordinate: CLLocationCoordinate2D(
                    latitude: listing.latitude,
                    longitude: listing.longitude),
                        title: listing.title
                )
                .frame(height: 200.0)
                .disabled(true)
            }
            .mask(RoundedRectangle(cornerRadius: 20, style: .continuous))
            .padding()
        }
    }
    var floatPanel: some View{
        ZStack{
            Section{
                HStack(alignment: .center){
                    Button(action: {
                        navigation.moveTo(
                            latitude: listing.latitude,
                            longitude: listing.longitude,
                            title: listing.title
                        )
                        print("Navigation start!")
                    }) {
                        HStack(alignment: .center, spacing: 5){
                            Image("navigation")
                                .resizable()
                                .renderingMode(.template)
                                .foregroundColor(Color("primaryBlue"))
                                .frame(width: 20, height: 20)
                            Text("Get Direction")
                                .fontWeight(.bold)
                                .foregroundColor(Color("primaryBlue"))
                        }
                        .padding(15)
                        .background(Blur(style: .systemThickMaterialLight))
                        .cornerRadius(15)
                        .shadow(color: .black.opacity(0.07), radius: 5, x: 0, y: 5)
                        .overlay(RoundedRectangle(cornerRadius: 15, style: .continuous).stroke(lineWidth: 1).fill(.white.opacity(0.7)))
                    }
                    
                    Spacer()
                    HStack{
                        Button(action: {
                            print("Info open!")
                        }) {
                            Image("star")
                                .resizable()
                                .renderingMode(.template)
                                .foregroundColor(Color("primaryBlue"))
                                .frame(width: 20, height: 20)
                        }
                        .padding(15)
                        .background(Blur(style: .systemThickMaterialLight))
                        .cornerRadius(15)
                        .shadow(color: .black.opacity(0.07), radius: 5, x: 0, y: 5)
                        .overlay(RoundedRectangle(cornerRadius: 15, style: .continuous).stroke(lineWidth: 1).fill(.white.opacity(0.7)))
                        
                        ShareLink(item: "https://google.com", preview: SharePreview(listing.title, image: listing.thumbnail)){
                            Image("share")
                                .resizable()
                                .renderingMode(.template)
                                .foregroundColor(Color("primaryBlue"))
                                .frame(width: 20, height: 20)
                        }
                        .padding(15)
                        .background(Blur(style: .systemThickMaterialLight))
                        .cornerRadius(15)
                        .shadow(color: .black.opacity(0.07), radius: 5, x: 0, y: 5)
                        .overlay(RoundedRectangle(cornerRadius: 15, style: .continuous).stroke(lineWidth: 1).fill(.white.opacity(0.7)))
                        // Share Button
                        
                    }
                    
                }
                .padding([.horizontal], 15)
                .padding([.vertical], 15)
                .background(Blur(style: .systemUltraThinMaterialLight))
                .frame(maxWidth: .infinity)
                .mask(RoundedRectangle(cornerRadius: 15, style: .continuous))
                .overlay(RoundedRectangle(cornerRadius: 15, style: .continuous).stroke(lineWidth: 0.5).fill(.white.opacity(0.5)))
                
            }
            .padding()
            
        }
    }
}

struct PlaceView_Previews: PreviewProvider {
    static var previews: some View {
        let listing = Listing(id: 1, rating: Rating(base: 4, rating: 4.5, count: 5, countText: "3"), address: "Adress", latitude: 40.7, longitude: -73.87, url: "https://phuquoc.guru", title: "City Street Coffee", content: "Компания WowVendor — один из крупнейших международных сервисов, оказывающих услуги в онлайн играх с 2014 года. За нашими плечами большой опыт и довольные клиенты. Это подтверждают 24 000 отзывов на платформе TrustPilot и более 100 000 посещений сайта каждый месяц. Наша миссия — помочь геймерам-любителям получить сложные достижения и прогресс, экономя сотни часов их личной жизни, а ПРО-игрокам дать возможность применять свои навыки и зарабатывать на любимом деле — компьютерных играх.", excerpt: "Test excerpt", price: 300, thumbnail: "https://picsum.photos/200",photos: [Photos(title: "", src: "https://picsum.photos/800"),Photos(title: "", src: "https://picsum.photos/800"),Photos(title: "", src: "https://picsum.photos/800")], distance: "1", distanceWithUnit: "3", isFeatured: true, authorID: "4", authorName: "Alex", viewCount: 123)
        PlaceView(listing: listing)
    }
}
