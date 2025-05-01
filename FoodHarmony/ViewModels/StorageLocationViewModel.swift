//
//  StorageLocationViewModel.swift
//  FoodHarmony
//
//  Created by Pascal Wiesner on 24.02.25.
//

import Combine
import SwiftUI


@MainActor
final class StorageLocationViewModel: ObservableObject {
    
    @Published var storageLocations: [StorageLocation] = []
    @Published var errorMessage: String?
    
    private let repository = StorageLocationRepository()
    
    func createStorageLocation(name: String, symbol: String) {
        Task {
            do {
                try repository.insert(name: name, symbol: symbol)
            } catch {
                errorMessage = error.localizedDescription
            }
        }
    }
    
    func deleteStorageLocation(storageLocation: StorageLocation) {
        guard let storagelocationID = storageLocation.id else { return }
        Task {
            do {
                try await repository.delete(by: storagelocationID)
            } catch {
                errorMessage = error.localizedDescription
            }
        }
    }
    
     func observeStorageLocations() {
        try? repository.observe { storages in
            self.storageLocations = storages
        }
    }
}


