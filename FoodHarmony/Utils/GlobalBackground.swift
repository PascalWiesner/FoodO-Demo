//
//  GlobalBackground.swift
//  FoodHarmony
//
//  Created by Pascal Wiesner on 26.02.25.
//

import SwiftUI

struct GlobalBackground: ViewModifier {
    
    func body(content: Content) -> some View {
        ZStack {
            Color(Color(.black)).ignoresSafeArea()
            content
        }
    }
}

extension View {
    func globalBackground() -> some View {
        modifier(GlobalBackground())
    }
}
