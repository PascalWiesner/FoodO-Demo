//
//  StorageLocationView.swift
//  FoodHarmony
//
//  Created by Pascal Wiesner on 24.02.25.
//

import SwiftUI
import TipKit

struct StorageLocationView: View {
    
    @EnvironmentObject private var viewModelStorageLocation: StorageLocationViewModel
    @EnvironmentObject private var viewModelProductItem: ProductItemViewModel
    @State private var navToaddStorageLocation: Bool = false
    @State private var navToStorageLocationDetailView: Bool = false
    @State private var selectedStorageLocationId: String?
    @State private var selectedStorageLocationName: String?
    let addStorageTip: AddStorageTip = .init()
    
    var body: some View {
        NavigationStack{
                ScrollView{
                    VStack(spacing: 60){
                    ForEach(viewModelStorageLocation.storageLocations){ storageLocation in
                        HStack(){
                            Button {
                                selectedStorageLocationId = storageLocation.id
                                selectedStorageLocationName = storageLocation.name
                                navToStorageLocationDetailView = true
                            } label: {
                                Image(systemName: storageLocation.symbol)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 70, height: 70)
                                    .foregroundStyle(Color("appColor"))
                                
                                Text(storageLocation.name)
                                    .foregroundStyle(.white)
                                    .font(.system(size: 30))
                                Spacer()
                            }
                            .contextMenu {
                                Button(role: .destructive) {
                                    viewModelStorageLocation.deleteStorageLocation(storageLocation: storageLocation)
                                } label: {
                                    Label("Löschen", systemImage: "trash")
                                }
                            }
                        }
                    }
                }
            }
                .padding(.top, 40)
                .onAppear {
                    viewModelStorageLocation.observeStorageLocations()
                }
                .globalBackground()
            .sheet(isPresented: $navToaddStorageLocation) {
                AddStorageLocationView()
                           .presentationDragIndicator(.visible)
                           .presentationDetents([.medium])
                   }
            .navigationDestination(isPresented: $navToStorageLocationDetailView) {
                       if let id = selectedStorageLocationId, let name = selectedStorageLocationName {
                           StorageLocationDetailView(storageLocationId: id, storageLocationName: name)
                               .environmentObject(viewModelProductItem)
                               .presentationDragIndicator(.visible)
                       }
                   }
            .navigationTitle("Lagerorte")
            .toolbarTitleDisplayMode(.inline)
            .toolbar{
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        navToaddStorageLocation = true
                    }) {
                        Image(systemName: "plus")
                            .foregroundStyle(Color("appColor"))
                    }
                    .popoverTip(addStorageTip)
                }
            }
            }
        }
    }


#Preview {
    StorageLocationView()
        .environmentObject(StorageLocationViewModel())
        .environmentObject(ProductItemViewModel())
}
