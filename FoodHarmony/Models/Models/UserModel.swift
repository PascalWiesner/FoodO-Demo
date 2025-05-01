//
//  UserModel.swift
//  FoodHarmony
//
//  Created by Pascal Wiesner on 15.02.25.
//

import Foundation

struct User: Codable, Identifiable {
    let id: String
    let email: String
    let signedUpOn: Date
}
