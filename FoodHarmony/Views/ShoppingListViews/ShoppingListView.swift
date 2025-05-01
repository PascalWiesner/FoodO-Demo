//
//  ShoppingListView.swift
//  FoodHarmony
//
//  Created by Pascal Wiesner on 23.02.25.
//

import SwiftUI

struct ShoppingListView: View {
    
    @EnvironmentObject var viewModelShoppingItems: ShoppingItemsViewModel
    @State private var navToShoppingListAddView = false
    @State private var checkmarkisOn = false
    
    var body: some View {
        
        NavigationStack{
            ScrollView{
                VStack{
                    ForEach(viewModelShoppingItems.shoppingItems){ shoppingItem in
                        HStack{
                            
                            Button {
                                viewModelShoppingItems.toggleCheckmark(shoppingItem: shoppingItem)
                            } label: {
                                Image(systemName: "checkmark")
                                    .foregroundStyle(shoppingItem.isChecked ? .black : .white)
                                    .font(.system(size: 30))
                                    .frame(width: 40, height: 40)
                                    .background(Color("appColor"))
                                
                                    .padding(.trailing, 80)
                                
                                Text(shoppingItem.name)
                                    .foregroundStyle(.white)
                                    .font(.system(size: 30))
                                
                                Spacer()
                            }
                        }
                        .contextMenu {
                            Button(role: .destructive) {
                                viewModelShoppingItems.deleteShoppingItem(shoppingItem: shoppingItem)
                            } label: {
                                Label("Löschen", systemImage: "trash")
                            }
                        }
                    }
                }
            }
            .padding(.top, 40)
            .globalBackground()
            .navigationTitle("Einkaufsliste")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        navToShoppingListAddView = true
                    }) {
                        Image(systemName: "plus")
                            .foregroundStyle(Color("appColor"))
                    }
                }
            }
        }
        .onAppear{
            viewModelShoppingItems.observeShoppingItems()
        }
        .sheet(isPresented: $navToShoppingListAddView) {
            ShoppingListAddView()
                .presentationDragIndicator(.visible)
                .presentationDetents([.medium])
            
        }
    }
}


#Preview {
    ShoppingListView()
        .environmentObject(ShoppingItemsViewModel())
}
