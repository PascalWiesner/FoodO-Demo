//
//  LicenseViewModifier.swift
//  FoodO
//
//  Created by Pascal Wiesner on 14.03.25.
//

import Foundation


import SwiftUI

struct LicenseViewMod: ViewModifier {
    func body(content: Content) -> some View {
        content
            .foregroundStyle(.white)
            .font(.system(size: 25))
            .frame(width: 380, height: 310)
            .background(.ultraThinMaterial)
            .cornerRadius(20)
    }
}
extension View{
    func LicenseViewModifier() -> some View{
        modifier(LicenseViewMod())
    }
}
