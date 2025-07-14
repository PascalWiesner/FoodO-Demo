//
//  ProductDetailItemViews.swift
//  FoodHarmony
//
//  Created by Pascal Wiesner on 23.02.25.
//

import SwiftUI

struct ProductDetailItemView: View {
    
    let item: ProductItem
    
    var body: some View {
        VStack(spacing: 70){
            
            VStack(spacing: 20){
                Text(item.name)
                    .font(.system(size: 30))
                    .foregroundStyle(.white)
                
                if let imageURL = URL(string: item.image3) {
                    AsyncImage(url: imageURL) { phase in
                        switch phase {
                        case .empty:
                            ProgressView()
                                .frame(width: 200, height: 200)
                        case .success(let image):
                            image
                                .resizable()
                                .scaledToFit()
                                .frame(width: 200, height: 200)
                                .clipShape(Rectangle())
                        case .failure:
                            Image(systemName: "photo")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 200, height: 200)
                                .foregroundColor(.gray)
                        @unknown default:
                            EmptyView()
                        }
                    }
                } else {
                    Image(systemName: "photo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 200, height: 200)
                        .foregroundColor(.gray)
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
    ProductDetailItemView(item: ProductItem(
        creatorID: "",
        name: "Beispielprodukt",
        image3: "https://example.com/image.jpg",
        isComplete: false,
        expirationDate: Date(),
        storageLocationId: "",
        ecoScoreGrade: ""
    ))
}

