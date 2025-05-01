//
//  AboutUsModifier.swift
//  FoodO
//
//  Created by Pascal Wiesner on 14.03.25.
//

import Foundation

import SwiftUI

struct AboutUsModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .foregroundStyle(.white)
            .frame(width: 380, height: 260)
            .background(.ultraThinMaterial)
            .cornerRadius(20)
    }
}
extension View{
    func AboutUsMod() -> some View{
        modifier(AboutUsModifier())
    }
}
