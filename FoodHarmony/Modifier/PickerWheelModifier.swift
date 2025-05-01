//
//  PickerStorageLocationModifier.swift
//  FoodHarmony
//
//  Created by Pascal Wiesner on 26.02.25.
//

import SwiftUI

struct PickerWheelMod: ViewModifier {
    func body(content: Content) -> some View {
        content
            .pickerStyle(.wheel)
            .frame(width: 500, height: 120)
    }
}
extension View{
    func PickerWheelModifier() -> some View{
        modifier(PickerWheelMod())
    }
}
