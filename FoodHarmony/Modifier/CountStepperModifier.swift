//
//  CountStepperModifier.swift
//  FoodHarmony
//
//  Created by Pascal Wiesner on 26.02.25.
//

import SwiftUI

struct CountStepperMod: ViewModifier {
    func body(content: Content) -> some View {
        content
            .foregroundStyle(.white)
            .background(Color("appColor"))
            .cornerRadius(20)
    }
}
extension View{
    func CountStepperModifier() -> some View{
        modifier(CountStepperMod())
    }
}
