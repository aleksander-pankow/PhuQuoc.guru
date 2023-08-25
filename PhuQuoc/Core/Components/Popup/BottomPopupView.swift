//
//  BottomPopupView.swift
//  PhuQuoc
//
//  Created by Aleksander Pankow on 19/07/2023.
//

import SwiftUI

struct BottomPopupView<Content: View>: View {

    let content: Content

    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                Spacer()
                content
                    .padding(.bottom, geometry.safeAreaInsets.bottom)
                    .background(Color.white)
                    .cornerRadius([.topLeading, .topTrailing], 16)
            }
            .edgesIgnoringSafeArea([.bottom])
        }
        .animation(.easeOut)
        .transition(.move(edge: .bottom))
    }
}
