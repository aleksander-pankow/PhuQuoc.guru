//
//  TabBarView.swift
//  PhuQuoc
//
//  Created by Aleksander Pankow on 09/06/2023.
//

import SwiftUI

struct TabBarView: View {
    var tabbarItems: [String]
    
    @Namespace private var menuItemTransition
    @Binding var selectedIndex: Int
    
    var body: some View {
        HStack {
            ForEach(tabbarItems.indices, id: \.self) { index in
                TabbarItem(name: tabbarItems[index], isActive: selectedIndex == index, namespace: menuItemTransition)
                    .frame(maxWidth: .infinity)
                    .onTapGesture {
                        withAnimation(.easeInOut) {
                            selectedIndex = index
                        }
                    }
            }
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(Color(.systemGray6))
        .cornerRadius(25)
    }
}
