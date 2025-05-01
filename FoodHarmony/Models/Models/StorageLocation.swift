//
//  StorageLocation.swift
//  FoodHarmony
//
//  Created by Pascal Wiesner on 24.02.25.
//

import FirebaseFirestore

struct StorageLocation: Codable, Identifiable{
    @DocumentID var id: String?
    
    var creatorID: User.ID
    var name: String
    var symbol: String
}
