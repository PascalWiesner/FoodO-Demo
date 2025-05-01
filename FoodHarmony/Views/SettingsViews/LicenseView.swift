//
//  LicenseView.swift
//  FoodHarmony
//
//  Created by Pascal Wiesner on 07.03.25.
//

import SwiftUI

struct LicenseView: View {
    var body: some View {
        
        VStack{
            Text("Unsere App nutzt die OpenFoodFacts API, um Nahrungsmittelinformationen bereitzustellen. OpenFoodFacts ist eine offene, kollaborative Lebensmittel-Datenbank, die unter der Open Database License (ODbL) veröffentlicht wird.")
                .padding()
        }
        .LicenseViewModifier()
        .padding()
        .globalBackground()
    }
}

#Preview {
    LicenseView()
}
