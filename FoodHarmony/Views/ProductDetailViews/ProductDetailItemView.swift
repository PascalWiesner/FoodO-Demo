//
//  ProductDetailItemViews.swift
//  FoodHarmony
//
//  Created by Pascal Wiesner on 23.02.25.
//

import SwiftUI

struct ProductDetailItemView: View {
    
    let item: ProductItem
    @State private var isImageLoaded = false
    
    
    var body: some View {
        VStack(spacing: 70){
            
            VStack(spacing: 20){
                Text(item.name)
                    .font(.system(size: 30))
                    .foregroundStyle(.white)
                
                if isImageLoaded, let imageURL = URL(string: item.image3) {
                    AsyncImage(url: imageURL) { image in
                        image
                            .resizable()
                            .scaledToFit()
                            .frame(width: 200, height: 200)
                            .clipShape(Rectangle())
                    } placeholder: {
                        ProgressView()
                    }
                } else {
                    ProgressView()
                        .onAppear {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                                isImageLoaded = true
                            }
                        }
                }
            }
            VStack(spacing: 20){
                Text("Umweltskala")
                    .font(.system(size: 30))
                EcoScoreGradeView(item: item)
            }
            
            Text("Ablaufdatum: \(item.expirationDate.formatted(date: .numeric, time: .omitted))")
                .BestBeforeDateTextModifier()
        }
        .padding(.bottom, 40)
    }
    
}


#Preview {
    ProductDetailItemView(item: ProductItem(creatorID: "", name: "", image3: "", isComplete: false, expirationDate: Date(), storageLocationId: "", ecoScoreGrade: ""))
}
