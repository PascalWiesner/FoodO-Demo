//
//  ProducContentListView.swift
//  FoodHarmony
//
//  Created by Pascal Wiesner on 26.02.25.
//

import SwiftUI

struct ProductContentListView: View {
    
    @EnvironmentObject var viewModel: ProductItemViewModel
    @Binding var searchText: String
    @Binding var navToProductDetailView: Bool
    @Binding var navToShoppingListView: Bool
    @Binding var selectedProduct: ProductItem?
    let holdToDeleteTip: HoldToDeleteTip = .init()
    
    var filteredProductItems: [ProductItem] {
        if searchText.isEmpty {
            return viewModel.productItems
        } else {
            return viewModel.productItems.filter { product in
                product.name.localizedCaseInsensitiveContains(searchText)
            }
        }
    }
    
    var body: some View {
        HStack(alignment: .top, spacing: 20) {
            if viewModel.productItems.isEmpty {
                Text("Füge neue Produkte hinzu, indem du den Plus Button drückst")
                    .font(.system(size: 40))
                    .foregroundStyle(.gray)
                    .frame(width: UIScreen.main.bounds.width, height: 500)
                    .background(Color.black)
            } else {
                let sortedItems = sortProductsByCategory(products: filteredProductItems)
                let pages = sortedItems.chunked(into: 9)
                
                ForEach(pages.indices, id: \.self) { pageIndex in
                    let pageItems = pages[pageIndex]
                    
                    LazyVGrid(
                        columns: [
                            GridItem(.flexible(), spacing: 20),
                            GridItem(.flexible(), spacing: 20),
                            GridItem(.flexible(), spacing: 20)
                        ],
                        spacing: 20
                    ) {
                        ForEach(pageItems) { item in
                            Button {
                                selectedProduct = item
                                navToProductDetailView = true
                            } label: {
                                ProductItemView(item: item)
                            }
                                .contextMenu {
                                    Button(role: .destructive) {
                                        viewModel.deleteProductItem(productItem: item)
                                    } label: {
                                        Label("Löschen", systemImage: "trash")
                                    }
                                }
                        }
                    }
                    .frame(width: UIScreen.main.bounds.width)
                    .popoverTip(holdToDeleteTip)
                }
            }
        }
    }
    func sortProductsByCategory(products: [ProductItem]) -> [ProductItem] {
        let redItems = products.filter { ProductItemView.getCategory(for: $0) == .red }
        let yellowItems = products.filter { ProductItemView.getCategory(for: $0) == .yellow }
        let greenItems = products.filter { ProductItemView.getCategory(for: $0) == .green }
        
        return redItems + yellowItems + greenItems
    }
}

#Preview {
    ProductContentListView(searchText: .constant(""), navToProductDetailView: .constant(false), navToShoppingListView: .constant(false), selectedProduct: .constant(ProductItem(creatorID: "", name: "", image3: "", isComplete: false, expirationDate: Date(), storageLocationId: "", ecoScoreGrade: "")))
        .environmentObject(ProductItemViewModel())
}
