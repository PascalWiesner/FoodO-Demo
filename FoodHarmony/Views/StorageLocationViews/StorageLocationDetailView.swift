//
//  StorageLocationDetailView.swift
//  FoodHarmony
//
//  Created by Pascal Wiesner on 25.02.25.
//

import SwiftUI

struct StorageLocationDetailView: View {
    
    @EnvironmentObject var viewModel: ProductItemViewModel
    @State private var searchText = ""
    @State private var navToProductDetailView = false
    @State private var navToShoppingListView = false
    @State private var selectedProduct: ProductItem?
    
    let storageLocationId: String
    let storageLocationName: String
    
    
    
    var body: some View {
            GeometryReader{ geometry in
                VStack {
                    ScrollView(.horizontal, showsIndicators: false) {
                        ProductContentStorageLocationListView(searchText: $searchText, navToProductDetailView: $navToProductDetailView, navToShoppingListView: $navToShoppingListView , selectedProduct: $selectedProduct, storageLocationId: storageLocationId)
                            .frame(minHeight: 600)
                    }
                    .onAppear {
                        viewModel.fetchProductsforStorageLocation(storageLocationId: storageLocationId)
                    }
                    .padding(.bottom, 20)
                }
                .frame(minHeight: geometry.size.height)
            }
            .ignoresSafeArea(.keyboard, edges: .bottom)
            .searchable(text: $searchText)
            .navigationTitle(storageLocationName)
            .navigationBarTitleDisplayMode(.inline)
            .navigationDestination(isPresented: $navToProductDetailView) {
                if let selectedProduct {
                    ProductDetailView(item: selectedProduct)
                }
            }
            .sheet(isPresented: $navToShoppingListView) {
                ShoppingListView()
                    .presentationDragIndicator(.visible)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .globalBackground()
    }
}


#Preview {
    StorageLocationDetailView(storageLocationId: "DeineStorageLocationId", storageLocationName: "")
        .environmentObject(ProductItemViewModel())
}
