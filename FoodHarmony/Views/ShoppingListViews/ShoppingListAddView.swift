//
//  ShoppingListAddView.swift
//  FoodHarmony
//
//  Created by Pascal Wiesner on 04.03.25.
//

import SwiftUI

struct ShoppingListAddView: View {
    
    @EnvironmentObject var viewModelShoppingItems: ShoppingItemsViewModel
    
    @State private var shoppingItemText = ""
    
    var body: some View {
        
        VStack(){
            Spacer()
            TextField("", text: $shoppingItemText, prompt: Text("Füge ein Produkt hinzu").foregroundStyle(.white))
                .TextfieldModifier()
                .padding(.horizontal, 20)
            Spacer()
            CreateButtonMain(buttonText: "Hinzufügen") {
                viewModelShoppingItems.createShoppingItem(name: shoppingItemText)
            }
        }
        .globalBackground()
    }
}

#Preview {
    ShoppingListAddView()
        .environmentObject(ShoppingItemsViewModel())
}
