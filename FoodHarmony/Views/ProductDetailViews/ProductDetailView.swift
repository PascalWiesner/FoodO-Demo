//
//  ProductDetailView.swift
//  FoodHarmony
//
//  Created by Pascal Wiesner on 23.02.25.
//

import SwiftUI

struct ProductDetailView: View {
    
    let item: ProductItem
    
    var body: some View {
            VStack{
                ProductDetailItemView(item: item)
                }
            .globalBackground()
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("Product Details")
                    .font(.system(size: 20))
                    .foregroundStyle(.white)
                    .bold()
            }
        }
    }
}

#Preview {
    ProductDetailView(item: ProductItem(creatorID: "", name: "", image3: "", isComplete: false, expirationDate: Date(), storageLocationId: "", ecoScoreGrade: ""))
}
