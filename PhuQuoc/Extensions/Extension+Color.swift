//
//  ColorExtension.swift
//  PhuQuoc
//
//  Created by Aleksander Pankow on 10/06/2023.
//

import Foundation
import SwiftUI

extension Color{
    static var randomPastel: Color {
        let hue = Double.random(in: 0...1)
        let saturation = Double.random(in: 0.5...1)
        let brightness = Double.random(in: 0.5...1)
        return Color(hue: hue, saturation: saturation, brightness: brightness)
    }
}
