//
//  CardView.swift
//  PhuQuoc
//
//  Created by Aleksander Pankow on 28/06/2023.
//

import SwiftUI

struct CardView: View {
    
    let listing: Listing
    let navigation = NavigationManager()
    
    private let width = UIScreen.main.bounds.width
    private let height = UIScreen.main.bounds.height
    
    @State private var isSheetPresented = false
    
    var body: some View {
        ZStack(alignment: .bottom){
            background
            content
        }
        .frame(height: 280.0)
        .overlay(alignment: .topTrailing){
            Image("Heart_01")
                .resizable()
                .renderingMode(.template)
                .foregroundColor(Color("primaryYellow"))
                .frame(width: 20, height: 20)
                .mask(Circle())
                .padding(10)
                .background(Blur(style: .systemUltraThinMaterialLight))
                .overlay(RoundedRectangle(cornerRadius: 30, style: .continuous).stroke(lineWidth: 0.5).fill(.white.opacity(0.5)))
                .cornerRadius(30)
                .offset(x:-20, y: 20)
        }
        .onTapGesture {
            isSheetPresented = true
        }
        .sheet(isPresented: $isSheetPresented){
            PlaceView(listing: listing)
        }
    }

    
    
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        let listing = Listing(id: 1, rating: Rating(base: 4, rating: 4, count: 5, countText: "3"), address: "Adress", latitude: 40.7, longitude: -73.87, url: "https://phuquoc.guru", title: "City Street Coffee", content: "Test content", excerpt: "Test excerpt", price: 300, thumbnail: "https://picsum.photos/800", photos: [Photos(title: "", src: "https://picsum.photos/800"),Photos(title: "", src: "https://picsum.photos/800"),Photos(title: "", src: "https://picsum.photos/800")], distance: "1", distanceWithUnit: "3", isFeatured: true, authorID: "4", authorName: "Alex", viewCount: 123)
        CardView(listing: listing)
    }
}

//MARK: - VIEW COMPONENTS
extension CardView{
    private var background: some View{
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
        }
        
    }
    private var content: some View{
        HStack(alignment: .center){
            VStack(alignment: .leading){
                HStack{
                    Text(listing.title)
                        .font(.title2)
                        .fontWeight(.medium)
                        .foregroundColor(Color.black)
                        .lineLimit(2)
                    
                    Image(listing.isFeatured ? "Wavy_Check" : "")
                        .resizable()
                        .renderingMode(.template)
                        .foregroundColor(.black)
                        .frame(
                            width: listing.isFeatured ? 20.0 : 0,
                            height: listing.isFeatured ? 20.0 : 0
                        )
                        .overlay()
                        {
                            Circle()
                                .frame(width: 15)
                                .foregroundColor(Color("primaryYellow").opacity(0.5))
                                .offset(x: 2, y: 3)
                        }
                }
                
                Text("4 km • Bar • Coctails")
                    .font(.headline)
                    .fontWeight(.light)
                    .foregroundColor(Color.black)
                    .lineLimit(2)
                
                
            }
            .padding()
            
            Spacer()

        }
        .frame(maxWidth: .infinity)
        .background(.white)
        .cornerRadius(15)
        .padding(25)
        .overlay(alignment: .topTrailing){
            HStack(alignment: .center, spacing: 5.0){
                Image("Star_Fill")
                .resizable()
                .renderingMode(.template)
                .foregroundColor(Color("primaryYellow"))
                .frame(width: 15, height: 15)
                Text(String(format: "%.1f", listing.rating.rating))
                    .font(.system(size: 14))
                    .fontWeight(.bold)
            }
            .padding(.horizontal, 10)
            .padding(.vertical, 5)
            .background(.white)
            .cornerRadius(15)
            .offset(x: -45, y: 10)
        }
    }
}
