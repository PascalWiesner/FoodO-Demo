//
//  HomeView.swift
//  FoodHarmony
//
//  Created by Pascal Wiesner on 16.02.25.
//

import SwiftUI
import TipKit

struct ProductsView: View {
    
    @AppStorage("hasAskedForNotificationPermission") private var hasAsked = false
    @EnvironmentObject var viewModel: ProductItemViewModel
    @EnvironmentObject var viewModelShoppingItems: ShoppingItemsViewModel
    @State private var searchText = ""
    @State private var navToProductDetailView = false
    @State private var navToShoppingListView = false
    @State private var selectedProduct: ProductItem?
    let shoppingListTip: ShoppingListTip = .init()

    
    init(){
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor : UIColor.white]
    }
    

    var body: some View {
        NavigationStack {
            GeometryReader { geometry in
                VStack {
                    ScrollView(.horizontal, showsIndicators: false) {
                        ProductContentListView(searchText: $searchText, navToProductDetailView: $navToProductDetailView, navToShoppingListView: $navToShoppingListView, selectedProduct: $selectedProduct)
                    }
                    .onAppear {
                        viewModel.observeProductItems()
                        viewModel.checkForExpiringProducts()
                    }
                    .padding(.bottom, 20)
                }
                .frame(minHeight: geometry.size.height)
            }
            .ignoresSafeArea(.keyboard, edges: .bottom)
            .navigationDestination(isPresented: $navToProductDetailView) {
                if let selectedProduct {
                    ProductDetailView(item: selectedProduct)
                }
            }
            .sheet(isPresented: $navToShoppingListView) {
                ShoppingListView()
                    .environmentObject(viewModelShoppingItems)
                    .presentationDragIndicator(.visible)
            }
            .globalBackground()
            .navigationTitle("Produkte")
            .navigationBarTitleDisplayMode(.inline)
            .searchable(text: $searchText)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        navToShoppingListView = true
                    }) {
                        Image(systemName: "cart")
                            .foregroundStyle(Color("appColor"))
                    }
                    .popoverTip(shoppingListTip)
                }
            }
            .onAppear{
                if !hasAsked {
                       viewModel.requestPermission()
                       hasAsked = true
                   }
            }
        }
    }
}
    
    

#Preview {
    ProductsView()
        .environmentObject(ProductItemViewModel())
        .environmentObject(ShoppingItemsViewModel())
}
