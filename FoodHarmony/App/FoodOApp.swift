//
//  FoodHarmonyApp.swift
//  FoodHarmony
//
//  Created by Pascal Wiesner on 10.02.25.
//

import SwiftUI
import Firebase
import TipKit


@main
struct FoodOApp: App {
    
    @StateObject var authVM = AuthViewModel()
    @StateObject var viewModel = ProductItemViewModel()
    @StateObject var viewModelAPI = ProductAPIViewModel()
    @StateObject var viewModelStorageLocation = StorageLocationViewModel()
    @StateObject var viewModelTafelDataBaseLowerSaxony = TafelDataBase()
    @StateObject var viewModelShoppingItem = ShoppingItemsViewModel()
    
    init() {
        FirebaseConfiguration.shared.setLoggerLevel(.min)
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            if !authVM.isUserSignedIn{
                LoginView()
            }else{
                MainTabView()
                    .task {
                        try? Tips.configure()
                        
                    }
            }
        }
        
        .environmentObject(authVM)
        .environmentObject(viewModel)
        .environmentObject(viewModelAPI)
        .environmentObject(viewModelStorageLocation)
        .environmentObject(viewModelTafelDataBaseLowerSaxony)
        .environmentObject(viewModelShoppingItem)
    }
}
