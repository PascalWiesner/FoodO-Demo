//
//  addProductView.swift
//  FoodHarmony
//
//  Created by Pascal Wiesner on 18.02.25.
//

import SwiftUI

struct AddProductView: View {
    
    @EnvironmentObject private var viewModelAPI: ProductAPIViewModel
    @EnvironmentObject var viewModelItem: ProductItemViewModel
    @EnvironmentObject private var viewModelStorageLocation: StorageLocationViewModel
    @State private var scannedCode: String?
    @State private var date = Date()
    @State private var selectedStorageIndex = 0
    
    
    var body: some View {
            VStack(spacing: 30) {
                BarcodeScannerViewModel(scannedCode: $scannedCode, viewModel: viewModelAPI)
                    .BarcodeScannerModifier()
                    .padding()
                
                Text(viewModelAPI.product?.productName ?? "Produkt nicht gefunden")
                    .font(.title)
                    .foregroundStyle(.white)
                
                if let imageUrl = viewModelAPI.product?.imageUrl, let url = URL(string: imageUrl) {
                    AsyncImage(url: url) { image in
                        image.resizable()
                            .scaledToFit()
                            .frame(width: 300, height: 200)
                            .cornerRadius(10)
                    } placeholder: {
                        ProgressView()
                    }
                }
                else{
                    Image("LogoLogin")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 300, height: 200)
                }
                DatePicker("Ablaufdatum", selection: $date, displayedComponents: .date)
                    .padding(.leading, 20)
                    .DatePickerModifier()
                Picker("Lagerort wählen", selection: $selectedStorageIndex) {
                    ForEach(viewModelStorageLocation.storageLocations.indices, id: \.self) { index in
                        Text(viewModelStorageLocation.storageLocations[index].name).tag(index)
                    }
                }
                .tint(.white)
                .frame(width: 350, height: 50)
                .background(Color("appColor"))
                .cornerRadius(20)
                CreateButtonMain(buttonText: "Hinzufügen") {
                    saveProduct()
                }
                .padding()
            }
            .padding(.top, 30)
            .globalBackground()
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("AddProduct")
                    .font(.system(size: 20))
                    .foregroundStyle(.white)
                    .bold()
            }
        }
        .onChange(of: scannedCode) { oldValue, newValue in
            if let barcode = newValue {
                viewModelAPI.fetchProduct(barcode: barcode)
            }
        }
    }
    
    func saveProduct(){
        guard let productName = viewModelAPI.product?.productName else {
            return
        }
        guard let productImage = viewModelAPI.product?.imageUrl else {
            return
        }
        
        guard let ecoScoreGrade = viewModelAPI.product?.ecoscoreGrade else {
            return
        }
        
        let productDate = date
        let storageLocationId = viewModelStorageLocation.storageLocations[selectedStorageIndex].id ?? ""
        
        viewModelItem.createProductItem(name: productName, url: productImage, date: productDate, storageLocationId: storageLocationId, ecoScoreGrade: ecoScoreGrade)
            }
    
    }


#Preview {
    AddProductView()
        .environmentObject(ProductAPIViewModel())
        .environmentObject(StorageLocationViewModel())
}
