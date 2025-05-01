//
//  Product.swift
//  FoodHarmony
//
//  Created by Pascal Wiesner on 19.02.25.
//

import Foundation

struct ProductResponse: Codable {
    let product: Product?
}

struct Product: Codable {
    let code: String
    let productName: String?
    let brands: String?
    let imageUrl: String?
    let ingredientsText: String?
    let nutriments: Nutriments?
    let ecoscoreGrade: String?

    enum CodingKeys: String, CodingKey {
        case code
        case productName = "product_name"
        case brands
        case imageUrl = "image_url"
        case ingredientsText = "ingredients_text"
        case nutriments
        case ecoscoreGrade = "ecoscore_grade"
    }
}

struct Nutriments: Codable {
    let energyKcal100g: Double?
    let sugars100g: Double?
    let fat100g: Double?
    let salt100g: Double?

    enum CodingKeys: String, CodingKey {
        case energyKcal100g = "energy-kcal_100g"
        case sugars100g = "sugars_100g"
        case fat100g = "fat_100g"
        case salt100g = "salt_100g"
    }
}
