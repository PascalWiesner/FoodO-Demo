//
//  ShoppingItemsViewModel.swift
//  FoodHarmony
//
//  Created by Pascal Wiesner on 04.03.25.
//

import FirebaseFirestore

@MainActor
final class ShoppingItemsViewModel: ObservableObject{
    
    @Published var shoppingItems: [ShoppingItem] = []
    @Published var errorMessage: String?
    
    private let repository = ShoppingListRepository()
    
    func createShoppingItem(name: String){
        Task{
            do{
                try repository.insert(name: name)
            } catch{
                errorMessage = error.localizedDescription
            }
        }
    }
    
    func deleteShoppingItem(shoppingItem: ShoppingItem){
        guard let shoppingItemID = shoppingItem.id else {return}
        Task{
            do {
                try await repository.delete(by: shoppingItemID)
            }catch{
                errorMessage = error.localizedDescription
            }
        }
    }
    
    func observeShoppingItems(){
        try? repository.Observe{ shoppingItems in
            self.shoppingItems = shoppingItems
        }
    }
    
    func toggleCheckmark(shoppingItem: ShoppingItem) {
        guard shoppingItem.id != nil else { return }
           var updatedItem = shoppingItem
           updatedItem.isChecked.toggle()

           Task {
               do {
                   try await repository.updateCheckmark(shoppingItem: updatedItem)
               } catch {
                   errorMessage = error.localizedDescription
               }
           }
       }
    
}
