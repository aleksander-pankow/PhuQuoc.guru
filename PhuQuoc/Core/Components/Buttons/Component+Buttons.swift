//
//  Component+Buttons.swift
//  PhuQuoc
//
//  Created by Aleksander Pankow on 15/07/2023.
//

import SwiftUI

//MARK: WelcomeView Custom styles

struct RoundedButton: View {
    var text: String
    var icon: Image?
    var bgColor: Color? = .white
    var textColor: Color? = .black
    var clicked: (() -> Void)
    
    var body: some View {
        Button(action: clicked) {
            HStack {
                Text(text)
                    .font(.title3)
                    .fontWeight(.bold)
                icon
            }
            .frame(maxWidth: .infinity)
            .foregroundColor(textColor)
            .padding(20)
            .background(bgColor)
            .mask(RoundedRectangle(cornerRadius: 15, style: .continuous))
            .overlay(RoundedRectangle(cornerRadius: 15, style: .continuous).stroke(lineWidth: 0.5).fill(.white.opacity(0.5)))
        }
    }
}
