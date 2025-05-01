//
//  ShoppingListModel.swift
//  FoodHarmony
//
//  Created by Pascal Wiesner on 04.03.25.
//

import FirebaseFirestore

struct ShoppingItem: Identifiable, Codable{
    @DocumentID var id: String?
    
    
    var creatorID: User.ID
    var name: String
    var isChecked: Bool = false
    
}
