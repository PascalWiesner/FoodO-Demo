//
//  DatePickerModifier.swift
//  FoodHarmony
//
//  Created by Pascal Wiesner on 26.02.25.
//

import SwiftUI

struct DatePickerMod: ViewModifier {
    func body(content: Content) -> some View {
        content
            .foregroundStyle(.white)
            .background(Color("appColor"))
            .cornerRadius(20)
            .frame(width: 350, height: 50)
    }
}
extension View{
    func DatePickerModifier() -> some View{
        modifier(DatePickerMod())
    }
}
