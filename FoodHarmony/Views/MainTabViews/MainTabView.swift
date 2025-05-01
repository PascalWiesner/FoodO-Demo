//
//  MainTabView.swift
//  FoodHarmony
//
//  Created by Pascal Wiesner on 16.02.25.
//

import SwiftUI
import MapKit


struct MainTabView: View {
    
    @State private var navToAddProductView: Bool = false
    @EnvironmentObject private var viewModelProductItem: ProductItemViewModel
    @EnvironmentObject private var viewModelAPI: ProductAPIViewModel
    @EnvironmentObject private var viewModelStorageLocation: StorageLocationViewModel
    @EnvironmentObject var user: AuthViewModel

    
    var body: some View {
        GeometryReader{ geometry in
            ZStack{
                TabView{
                    Tab("Produkte", systemImage: "takeoutbag.and.cup.and.straw.fill"){
                        ProductsView()
                            .environmentObject(viewModelProductItem)
                    }
                    Tab("Lagerort", systemImage: "refrigerator.fill"){
                        StorageLocationView()
                            .environmentObject(viewModelStorageLocation)
                    }
                    Tab("", systemImage: ""){
                        EmptyView()
                    }
                    Tab("Essen spenden", systemImage: "map.fill"){
                        FoodDistributionView()
                    }
                    Tab("Info", systemImage: "info.square.fill"){
                        SettingsView()
                            .environmentObject(user)
                    }
                }
                Button(action: {
                    viewModelStorageLocation.observeStorageLocations()
                    navToAddProductView = true
                }) {
                    ZStack {
                        Circle()
                            .frame(width: 70, height: 70)
                            .foregroundStyle(Color("appColor"))
                        Image(systemName: "plus")
                            .foregroundStyle(.white)
                            .font(.system(size: 40))
                    }
                }
                .padding(.top, 680)
            }
            .frame(minHeight: geometry.size.height)
            
        }
        .ignoresSafeArea(.keyboard, edges: .bottom)
        .sheet(isPresented: $navToAddProductView) {
            AddProductView()
                .environmentObject(viewModelProductItem)
                .environmentObject(viewModelAPI)
                .presentationDragIndicator(.visible)
        }
        .onAppear {
            let tabBarAppearance = UITabBarAppearance()
            tabBarAppearance.configureWithOpaqueBackground()
            tabBarAppearance.backgroundColor = UIColor.black
            
            let customColor = UIColor(Color("appColor"))
            
            tabBarAppearance.stackedLayoutAppearance.selected.iconColor = customColor
            tabBarAppearance.stackedLayoutAppearance.selected.titleTextAttributes = [.foregroundColor: customColor]
            tabBarAppearance.stackedLayoutAppearance.normal.iconColor = UIColor.white
            tabBarAppearance.stackedLayoutAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.white]
            
            UITabBar.appearance().standardAppearance = tabBarAppearance
            UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
        }
    }
}

#Preview {
    MainTabView()
        .environmentObject(AuthViewModel())
        .environmentObject(ProductItemViewModel())
        .environmentObject(ProductAPIViewModel())
        .environmentObject(StorageLocationViewModel())
        .environmentObject(TafelDataBase())
        .environmentObject(ShoppingItemsViewModel())
    
}

