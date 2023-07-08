//
//  KeyboardExtension.swift
//  PhuQuoc
//
//  Created by Aleksander Pankow on 28/05/2023.
//

import Foundation
import SwiftUI

#if canImport(UIKit)
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
#endif
