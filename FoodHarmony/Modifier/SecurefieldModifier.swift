//
//  SecurefieldModifier.swift
//  FoodHarmony
//
//  Created by Pascal Wiesner on 26.02.25.
//

import SwiftUI

struct SecurefieldMod: ViewModifier {
    func body(content: Content) -> some View {
        content
            .textInputAutocapitalization(.never)
            .foregroundStyle(.white)
    }
}
extension View{
    func SecurefieldModifier() -> some View{
        modifier(SecurefieldMod())
    }
}
