//
//  ProductModel.swift
//  FoodHarmony
//
//  Created by Pascal Wiesner on 20.02.25.
//

import FirebaseFirestore

struct ProductItem: Identifiable, Codable{
    @DocumentID var id: String?
    
    var creatorID: User.ID
    var name: String
    var image3: String
    var isComplete: Bool
    var expirationDate: Date
    var storageLocationId: String
    var ecoScoreGrade: String
}
