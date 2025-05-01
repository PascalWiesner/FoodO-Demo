//
//  CreateLogoutButtonSettings.swift
//  FoodHarmony
//
//  Created by Pascal Wiesner on 07.03.25.
//

import SwiftUI

struct CreateLogoutButtonSettings: View {
    var buttonText: String
    var buttonAction: () -> Void
    
    var body: some View {
        Button(action: buttonAction) {
            Text(buttonText)
                .font(.system(size: 30))
                .foregroundStyle(.white)
                .frame(width: 300, height: 50)
                .background(
                    Color("appColor")
                )
                .cornerRadius(20)
        }
    }
}
