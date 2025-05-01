//
//  ProductViewModel.swift
//  FoodHarmony
//
//  Created by Pascal Wiesner on 19.02.25.
//

import Foundation

@MainActor
class ProductAPIViewModel: ObservableObject {
    @Published var product: Product?
    @Published var errorMessage: String?

    func fetchProduct(barcode: String) {
        guard !barcode.isEmpty else {
            errorMessage = "Kein Barcode erkannt"
            return
        }

        Task {
            do {
                self.product = try await getProductFromAPI(barcode: barcode)
            } catch {
                self.errorMessage = "Fehler beim Laden des Produkts: \(error.localizedDescription)"
            }
        }
    }
    
    func getProductFromAPI(barcode: String) async throws -> Product? {
        let urlString = "https://world.openfoodfacts.org/api/v2/product/\(barcode).json"

        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }

        let (data, _) = try await URLSession.shared.data(from: url)
        let result = try JSONDecoder().decode(ProductResponse.self, from: data)

        return result.product
    }

}


