//
//  BarcodeScannerModifier.swift
//  FoodHarmony
//
//  Created by Pascal Wiesner on 26.02.25.
//

import SwiftUI

struct BarcodeScannerMod: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(height: 150)
            .cornerRadius(20)
    }
}
extension View{
    func BarcodeScannerModifier() -> some View{
        modifier(BarcodeScannerMod())
    }
}

