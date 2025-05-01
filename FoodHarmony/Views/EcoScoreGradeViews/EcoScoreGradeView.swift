//
//  EcoScoreGradeView.swift
//  FoodHarmony
//
//  Created by Pascal Wiesner on 27.02.25.
//

import SwiftUI

struct EcoScoreGradeView: View {
    
    let item: ProductItem
    
    var body: some View {
        
        HStack(spacing: 20){
            if item.ecoScoreGrade == "a-plus"{
                CreateEcoScoreScala(text: "A+", isSelected: true)
            } else{
                CreateEcoScoreScala(text: "A+", isSelected: false)
            }
            if item.ecoScoreGrade == "a"{
                CreateEcoScoreScala(text: "A", isSelected: true)
            }else{
                CreateEcoScoreScala(text: "A", isSelected: false)
            }
            if item.ecoScoreGrade == "b"{
                CreateEcoScoreScala(text: "B", isSelected: true)
            }else{
                CreateEcoScoreScala(text: "B", isSelected: false)
            }
            if item.ecoScoreGrade == "c"{
                CreateEcoScoreScala(text: "C", isSelected: true)
            }else{
                CreateEcoScoreScala(text: "C", isSelected: false)
            }
            if item.ecoScoreGrade == "d"{
                CreateEcoScoreScala(text: "D", isSelected: true)
            }else{
                CreateEcoScoreScala(text: "D", isSelected: false)
            }

        }
    }
}

#Preview {
    EcoScoreGradeView(item: ProductItem(creatorID: "", name: "", image3: "", isComplete: false, expirationDate: Date(), storageLocationId: "", ecoScoreGrade: ""))
}
