//
//  TextFieldModifier.swift
//  FoodHarmony
//
//  Created by Pascal Wiesner on 15.02.25.
//

import SwiftUI

struct TextfieldMod: ViewModifier {
    func body(content: Content) -> some View {
        content
            .textInputAutocapitalization(.never)
            .foregroundStyle(.white)
            .padding(.bottom, 5)
        Rectangle()
            .frame(height: 1)
            .foregroundColor(.white)
    }
}
extension View{
    func TextfieldModifier() -> some View{
        modifier(TextfieldMod())
    }
}
