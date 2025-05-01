//
//  BestBeforeDateTextModifier.swift
//  FoodO
//
//  Created by Pascal Wiesner on 11.03.25.
//

import SwiftUI

struct BestBeforeDateTextMod: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(size: 30))
            .foregroundStyle(.white)
            .frame(width: 390, height: 60)
            .background(.thinMaterial)
            .clipShape(Rectangle()).cornerRadius(20)
    }
}
extension View{
    func BestBeforeDateTextModifier() -> some View{
        modifier(BestBeforeDateTextMod())
    }
}

