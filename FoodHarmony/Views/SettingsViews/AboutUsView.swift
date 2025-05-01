//
//  AboutUsView.swift
//  FoodHarmony
//
//  Created by Pascal Wiesner on 10.03.25.
//

import SwiftUI

struct AboutUsView: View {
    var body: some View {
        VStack(spacing: 20){
            Text("App Developer")
                .font(.system(size: 35))
                .bold()
            Text("Pascal Wiesner")
                .font(.system(size: 30))
        }
        .AboutUsMod()
        .globalBackground()
    }
}

#Preview {
    AboutUsView()
}
