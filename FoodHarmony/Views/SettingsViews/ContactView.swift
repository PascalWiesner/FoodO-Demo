//
//  ContactView.swift
//  FoodHarmony
//
//  Created by Pascal Wiesner on 10.03.25.
//

import SwiftUI

struct ContactView: View {
    var body: some View {
        VStack(spacing: 20){
            Text("Kontakt")
                .font(.system(size: 35))
                .bold()
            Text("pascal-wiesner@gmx.de")
                .font(.system(size: 30))
                .tint(.white)
        }
        .ContactViewModifier()
        .globalBackground()
    }
}

#Preview {
    ContactView()
}
