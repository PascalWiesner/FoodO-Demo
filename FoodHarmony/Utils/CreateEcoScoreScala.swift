//
//  CreateEcoScoreScala.swift
//  FoodHarmony
//
//  Created by Pascal Wiesner on 27.02.25.
//

import SwiftUI

struct CreateEcoScoreScala: View {
    
    var text: String
    var isSelected: Bool = false
    
    var body: some View {
        Text(text)
            .font(.system(size: 25))
            .bold()
            .foregroundStyle(.white)
            .frame(width: 60, height: 60)
            .background(.thinMaterial)
            .clipShape(Circle())
            .overlay(
                Circle()
                    .stroke(isSelected ? Color.white : Color.clear, lineWidth: 3)
            )
    }
}

#Preview {
    CreateEcoScoreScala(text: "")
}
