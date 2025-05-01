//
//  ContactViewModifier.swift
//  FoodO
//
//  Created by Pascal Wiesner on 14.03.25.
//

import Foundation

import SwiftUI

struct ContactViewMod: ViewModifier {
    func body(content: Content) -> some View {
        content
            .foregroundStyle(.white)
            .frame(width: 380, height: 290)
            .background(.ultraThinMaterial)
            .cornerRadius(20)
    }
}
extension View{
    func ContactViewModifier() -> some View{
        modifier(ContactViewMod())
    }
}
