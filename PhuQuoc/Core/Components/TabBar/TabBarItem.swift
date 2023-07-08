//
//  TabBarItem.swift
//  PhuQuoc
//
//  Created by Aleksander Pankow on 09/06/2023.
//

import SwiftUI

struct TabbarItem: View {
    var name: String
    var isActive: Bool = false
    let namespace: Namespace.ID
    
    var body: some View {
        if isActive {
            switch name {
            case "Home":
                Image("home")
                    .renderingMode(.template)
                    .resizable()
                    .frame(width: 25, height: 25)
                    .padding(.horizontal)
                    .padding(.vertical, 4)
                    .foregroundColor(Color("primaryBlue"))
                    //.matchedGeometryEffect(id: "highlightmenuitem", in:namespace)
                
            case "Travel":
                Image("map")
                    .renderingMode(.template)
                    .resizable()
                    .frame(width: 25, height: 25)
                    .padding(.horizontal)
                    .padding(.vertical, 4)
                    .foregroundColor(Color("primaryBlue"))
                    //.matchedGeometryEffect(id: "highlightmenuitem", in:namespace)
            case "Events":
                Image("radio")
                    .renderingMode(.template)
                    .resizable()
                    .frame(width: 25, height: 25)
                    .padding(.horizontal)
                    .padding(.vertical, 4)
                    .foregroundColor(Color("primaryBlue"))
                    //.matchedGeometryEffect(id: "highlightmenuitem", in:namespace)
            case "Profile":
                Image("user")
                    .renderingMode(.template)
                    .resizable()
                    .frame(width: 25, height: 25)
                    .padding(.horizontal)
                    .padding(.vertical, 4)
                    .foregroundColor(Color("primaryBlue"))
                    //.matchedGeometryEffect(id: "highlightmenuitem", in:namespace)
            default:
                Image("home")
                    .renderingMode(.template)
                    .resizable()
                    .frame(width: 25, height: 25)
                    .padding(.horizontal)
                    .padding(.vertical, 4)
                    .foregroundColor(Color("primaryBlue"))
                    //.matchedGeometryEffect(id: "highlightmenuitem", in:namespace)
            }

        } else {
            switch name {
            case "Home":
                Image("home")
                    .renderingMode(.template)
                    .resizable()
                    .foregroundColor(Color.gray)
                    .frame(width: 25, height: 25)
                
            case "Travel":
                Image("map")
                    .renderingMode(.template)
                    .resizable()
                    .foregroundColor(Color.gray)
                    .frame(width: 25, height: 25)
            case "Events":
                Image("radio")
                    .renderingMode(.template)
                    .resizable()
                    .foregroundColor(Color.gray)
                    .frame(width: 25, height: 25)
            case "Profile":
                Image("user")
                    .renderingMode(.template)
                    .resizable()
                    .foregroundColor(Color.gray)
                    .frame(width: 25, height: 25)
            default:
                Image("home")
                    .renderingMode(.template)
                    .resizable()
                    .foregroundColor(Color.gray)
                    .frame(width: 25, height: 25)
            }
        }
        
    }
}
