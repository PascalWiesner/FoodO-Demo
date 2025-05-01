//
//  LogoStandart.swift
//  FoodHarmony
//
//  Created by Pascal Wiesner on 26.02.25.
//

import SwiftUI

struct LogoStandart: View {
    var body: some View {
        Image("LogoLogin")
            .resizable()
            .scaledToFit()
            .frame(width: 250, height: 250)
            .clipShape(Circle())
    }
}

#Preview {
    LogoStandart()
}
