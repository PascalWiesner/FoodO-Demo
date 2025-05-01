//
//  ProductItemView.swift
//  FoodHarmony
//
//  Created by Pascal Wiesner on 20.02.25.
//

import SwiftUI

struct ProductItemView: View {
    
    let item: ProductItem
    @State private var isImageLoaded = false
    @EnvironmentObject private var viewModelProductItem: ProductItemViewModel

    var body: some View {
        let remainingDays = ProductItemView.daysRemaining(for: item)
        let borderColor = ProductItemView.getBorderColor(for: remainingDays)

        VStack(spacing: 8) {
            if isImageLoaded, let imageURL = URL(string: item.image3) {
                AsyncImage(url: imageURL) { image in
                    image
                        .resizable()
                        .scaledToFit()
                        .frame(width: 90, height: 90)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(borderColor, lineWidth: 5)
                        )
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

            Text(item.name)
                .foregroundStyle(.white)
                .font(.system(size: 20))
                .bold()
                .lineLimit(3)
                .frame(minHeight: 75)
        }
    }


    static func daysRemaining(for item: ProductItem) -> Int {
        let calendar = Calendar.current
        let startOfToday = calendar.startOfDay(for: Date())
        let startOfExpiration = calendar.startOfDay(for: item.expirationDate)

        return calendar.dateComponents([.day], from: startOfToday, to: startOfExpiration).day ?? 0
    }

    static func getBorderColor(for days: Int) -> Color {
        switch days {
        case ...3:
            return .red
        case 4...10:
            return .yellow
        default:
            return .green
        }
    }

    static func getCategory(for item: ProductItem) -> StrokeCategory {
        let daysLeft = daysRemaining(for: item)

        switch daysLeft {
        case ...3:
            return .red
        case 4...10:
            return .yellow
        default:
            return .green
        }
    }
    
    
    
}

enum StrokeCategory {
    case red, yellow, green
}
