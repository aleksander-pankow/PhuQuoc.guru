//
//  Extension+View.swift
//  PhuQuoc
//
//  Created by Aleksander Pankow on 19/07/2023.
//

import SwiftUI

extension View {
    func cornerRadius(bottom radius: CGFloat) -> some View {
        clipShape(CustomCorner(radius: radius))
    }
    
    func popup<OverlayView: View>(isPresented: Binding<Bool>,
                                      blurRadius: CGFloat = 3,
                                      blurAnimation: Animation? = .linear,
                                      @ViewBuilder overlayView: @escaping () -> OverlayView) -> some View {
            return blur(radius: isPresented.wrappedValue ? blurRadius : 0)
                .animation(blurAnimation)
                .allowsHitTesting(!isPresented.wrappedValue)
                .modifier(OverlayModifier(isPresented: isPresented, overlayView: overlayView))
        }
}

struct CustomCorner: Shape {
    var radius: CGFloat

    func path(in rect: CGRect) -> Path {
        var path = Path()

        let topLeft = CGPoint(x: rect.minX, y: rect.minY)
        let topRight = CGPoint(x: rect.maxX, y: rect.minY)
        let bottomRight = CGPoint(x: rect.maxX, y: rect.maxY - radius)
        let bottomLeft = CGPoint(x: rect.minX, y: rect.maxY - radius)

        path.move(to: topLeft)
        path.addLine(to: topRight)
        path.addLine(to: bottomRight)
        path.addArc(center: CGPoint(x: bottomRight.x - radius, y: bottomRight.y), radius: radius, startAngle: Angle(degrees: 0), endAngle: Angle(degrees: 90), clockwise: false)
        path.addLine(to: bottomLeft)
        path.addLine(to: topLeft)

        return path
    }
}

struct OverlayModifier<OverlayView: View>: ViewModifier {
    
    @Binding var isPresented: Bool
    let overlayView: OverlayView
    
    init(isPresented: Binding<Bool>, @ViewBuilder overlayView: @escaping () -> OverlayView) {
        self._isPresented = isPresented
        self.overlayView = overlayView()
    }
    
    func body(content: Content) -> some View {
        content.overlay(isPresented ? overlayView : nil)
    }
}
