//
//  FAQContainerModifier.swift
//  FoodO
//
//  Created by Pascal Wiesner on 14.03.25.
//

import SwiftUI

struct FAQContainerMod: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(width: 380, height: 290)
            .background(.ultraThinMaterial)
            .cornerRadius(20)
    }
}
extension View{
    func FAQContainerModifier() -> some View{
        modifier(FAQContainerMod())
    }
}

