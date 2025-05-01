//
//  LogoSettings.swift
//  FoodHarmony
//
//  Created by Pascal Wiesner on 08.03.25.
//

import SwiftUI

struct LogoSettings: View {
    var body: some View {
        Image("LogoLogin")
            .resizable()
            .scaledToFit()
            .frame(width: 200, height: 200)
            .clipShape(Circle())
    }
}

#Preview {
    LogoStandart()
}
