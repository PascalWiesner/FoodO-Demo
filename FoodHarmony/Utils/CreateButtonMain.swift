//
//  CreateButton.swift
//  FoodHarmony
//
//  Created by Pascal Wiesner on 15.02.25.
//

import SwiftUI

struct CreateButtonMain: View {
    var buttonText: String
    var buttonAction: () -> Void
    
    var body: some View {
        Button(action: buttonAction) {
            Text(buttonText)
                .font(.system(size: 20))
                .foregroundStyle(.white)
                .frame(width: 200, height: 50)
                .background(
                    Color("appColor")
                )
                .cornerRadius(20)
        }
    }
}
