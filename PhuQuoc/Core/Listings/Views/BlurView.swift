//
//  BlurView.swift
//  PhuQuoc
//
//  Created by Aleksander Pankow on 11/06/2023.
//

import SwiftUI
import SwiftUIX

struct BlurView: View {
    var body: some View {
        ZStack {
            Image("ava")
                .resizable()
                .aspectRatio(contentMode: .fill)
            VisualEffectBlurView(blurStyle: .systemUltraThinMaterial, content: {
                Text("Hello, World!")
                    
            })
            .frame(width: 250, height: 150)
            .mask(RoundedRectangle(cornerRadius: 30, style: .continuous))
            .overlay(RoundedRectangle(cornerRadius: 30, style: .continuous).stroke(lineWidth: 0.5).fill(.white.opacity(0.5)))
            .shadow(color: .black.opacity(0.3), radius: 20, x: 0, y: 0)
        }
        
    }
}

struct BlurView_Previews: PreviewProvider {
    static var previews: some View {
        BlurView()
    }
}
