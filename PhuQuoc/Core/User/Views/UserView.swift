//
//  UserView.swift
//  PhuQuoc
//
//  Created by Aleksander Pankow on 10/06/2023.
//

import SwiftUI
import FirebaseAuth

struct UserView: View {
    
    @StateObject var vm = UserViewModel()
    
    var body: some View {
        VStack{
            header
            Spacer()
            menu
            Spacer()
        }
        .padding(.horizontal, 50)
        .onAppear(){
            //userViewModel.fetchCurrentUserInfo()
        }
    }
}

struct UserView_Previews: PreviewProvider {
    static var previews: some View {
        UserView()
    }
}

//MARK: - VIEW COMPONENTS

extension UserView {
    private var header: some View {
        VStack{
            AsyncImage(url: URL(string: "https://picsum.photos/300")) { phase in
                if let image = phase.image {
                    image // Displays the loaded image.
                        .resizable()
                } else if phase.error != nil {
                    Color.red // Indicates an error.
                } else {
                    ProgressView() // Acts as a placeholder.
                }
            }
            .frame(width: 100, height: 100)
            .mask(Circle())
            
            Text(vm.testUser.name)
                .font(.title2)
                .fontWeight(.bold)
            
            
            NavigationLink(destination: UserEditView(displayName: vm.testUser.name, phoneNumber: vm.testUser.phone ?? "", birthdate: Date()), label: {
                Text("Edit profile")
                    .padding()
                    .foregroundColor(.white)
                    .background(Color("PrimaryBlue"))
                    .cornerRadius(15)
            })
        }
    }
    private var menu: some View{
        Group{
            HStack{
                VStack(alignment: .leading, spacing: 10.0){
                    Section{
                        HStack(spacing: 20.0){
                            ZStack {
                                Circle()
                                    .foregroundColor(Color("PrimaryBlue").opacity(0.2))
                                Image(systemName: "gear")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 25, height: 25)
                                    .foregroundColor(Color("PrimaryBlue"))
                            }
                            .frame(width: 45, height: 45)
                            Text("Settings")
                        }
                        HStack(spacing: 20.0){
                            ZStack {
                                Circle()
                                    .foregroundColor(Color("PrimaryBlue").opacity(0.2))
                                Image(systemName: "heart")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 25, height: 25)
                                    .foregroundColor(Color("PrimaryBlue"))
                            }
                            .frame(width: 45, height: 45)
                            Text("Favourite List")
                        }
                        HStack(spacing: 20.0){
                            ZStack {
                                Circle()
                                    .foregroundColor(Color("PrimaryBlue").opacity(0.2))
                                Image(systemName: "qrcode")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 25, height: 25)
                                    .foregroundColor(Color("PrimaryBlue"))
                            }
                            .frame(width: 45, height: 45)
                            Text("My coupons")
                        }
                        HStack(spacing: 20.0){
                            ZStack {
                                Circle()
                                    .foregroundColor(Color("PrimaryBlue").opacity(0.2))
                                Image(systemName: "megaphone")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 25, height: 25)
                                    .foregroundColor(Color("PrimaryBlue"))
                            }
                            .frame(width: 45, height: 45)
                            Text("My events")
                        }
                    }
                    Rectangle().foregroundColor(.clear).frame(height: 20)
                    Section{
                        HStack(spacing: 20.0){
                            ZStack {
                                Circle()
                                    .foregroundColor(Color("PrimaryBlue").opacity(0.2))
                                Image(systemName: "info")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 20, height: 20)
                                    .foregroundColor(Color("PrimaryBlue"))
                            }
                            .frame(width: 45, height: 45)
                            Text("Info")
                        }
                        HStack(spacing: 20.0){
                            ZStack {
                                Circle()
                                    .foregroundColor(Color("PrimaryBlue").opacity(0.2))
                                Image(systemName: "arrow.right.square")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 20, height: 20)
                                    .foregroundColor(Color("PrimaryBlue"))
                            }
                            .frame(width: 45, height: 45)
                            Text("Logout")
                                .foregroundColor(Color.red)
                        }
                    }
                }
                Spacer()
            }
        }
    }
}
