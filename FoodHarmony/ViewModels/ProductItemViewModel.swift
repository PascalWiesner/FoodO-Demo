//
//  ProductItemVIewModel.swift
//  FoodHarmony
//
//  Created by Pascal Wiesner on 20.02.25.
//

import Combine
import SwiftUI
import UserNotifications

@MainActor
final class ProductItemViewModel: ObservableObject {
    
    @Published var productItems: [ProductItem] = []
    @Published var errorMessage: String?
    @Published var isComplete: Bool = false
    
    private let repository = ProductItemRepository()
    private let center = UNUserNotificationCenter.current()
    
    
    func createProductItem(name: String, url: String, date: Date, storageLocationId: String, ecoScoreGrade: String) {
           Task {
               do {
                   try repository.insert(name: name, image: url, date: date, storageLocationID: storageLocationId, ecoScoreGrade: ecoScoreGrade)
               } catch {
                   errorMessage = error.localizedDescription
               }
           }
       }
    
    func toggleComplete(productItem: ProductItem) {
        Task {
            do {
                try await repository.updateIsComplete(by: productItem.id, isComplete: !productItem.isComplete)
            } catch {
                errorMessage = error.localizedDescription
            }
        }
    }
    
    func deleteProductItem(productItem: ProductItem) {
        guard let productItemID = productItem.id else { return }
        Task {
            do {
                try await repository.delete(by: productItemID)
            } catch {
                errorMessage = error.localizedDescription
            }
        }
    }
    
    func fetchProductsforStorageLocation(storageLocationId: String) {
        Task {
            do {
                let products = try await repository.fetchProducts(for: storageLocationId)
                self.productItems = products
                
                checkForExpiringProducts()
                
            } catch {
                errorMessage = error.localizedDescription
            }
        }
    }
    
     func observeProductItems() {
        try? repository.observe { productItems in
            self.productItems = productItems
        }
    }
    
    func requestPermission(){
        
        center.requestAuthorization(options: [.alert, .sound, .badge]){ granted, error in
            if let error{
                print(error)
            }
            
            guard granted else {
                print("Benachrichtigung wurden abgelehnt un können NICHT gesendet werden.")
                return
            }

            print("Benachrichtigungen können gesendet werden.")
        }
    }
    func scheduleNotification(for item: ProductItem) {
        let remainingDays = ProductItemView.daysRemaining(for: item)
        
      
        guard remainingDays > 0 else { return }

        let content = UNMutableNotificationContent()
        content.title = "Produkt läuft bald ab!"
        content.body = "Das Produkt \(item.name) läuft in \(remainingDays) Tagen ab!"
        content.sound = UNNotificationSound.default

    
        var dateComponents = DateComponents()
        dateComponents.hour = 9
        dateComponents.minute = 0

        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)


        let request = UNNotificationRequest(identifier: "expiring_\(item.id ?? "")", content: content, trigger: trigger)

        center.add(request) { error in
            if let error {
                print("Fehler beim Planen der Benachrichtigung: \(error)")
            } else {
                print("Benachrichtigung für \(item.name) um 9:00 Uhr geplant.")
            }
        }
    }
    
    func checkForExpiringProducts() {
        for item in productItems {
            let remainingDays = ProductItemView.daysRemaining(for: item)
            
            if remainingDays == 3 {
                scheduleNotification(for: item)
            }
        }
    }
}

