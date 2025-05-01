//
//  AddStorageLocationView.swift
//  FoodHarmony
//
//  Created by Pascal Wiesner on 24.02.25.
//

import SwiftUI

struct AddStorageLocationView: View {
    
    @EnvironmentObject private var viewModelStorageLocation: StorageLocationViewModel
    
    @State private var storageLocationName = ["Kühlschrank", "Gefrierschrank", "Vorratsraum", "Süßigkeitenschublade"]
    @State private var storageLocationNumber = ["1", "2", "3"]
    @State private var selection = 0
    @State private var customName = ""
    
    @State private var symbolMapping: [String: String] = [
        "Kühlschrank": "refrigerator.fill",
        "Gefrierschrank": "snowflake",
        "Vorratsraum": "cabinet.fill",
        "Süßigkeitenschublade": "popcorn.fill"
    ]
    
    
    var body: some View {
            VStack{
                Spacer()
                Picker("StorageLocation", selection: $selection) {
                    ForEach(storageLocationName.indices, id: \.self) { index in
                        Text(storageLocationName[index]).tag(index)
                            .foregroundColor(.white)
                    }
                }
                .PickerWheelModifier()
                Spacer()
                
                TextField("", text: $customName, prompt: Text("Lagerort Name").foregroundStyle(.white))
                    .TextfieldModifier()
                    .padding(.horizontal, 65)
                Spacer()
                CreateButtonMain(buttonText: "Hinzufügen") {
                    let selectedStorage = storageLocationName[selection]
                    let selectedNumber = customName.isEmpty ? "1" : customName
                    let selectionText = "\(selectedStorage) \(selectedNumber)"
                    let symbol = symbolMapping[selectedStorage] ?? "questionmark.circle"
                    viewModelStorageLocation.createStorageLocation(name: selectionText, symbol: symbol)
                }
            }
            .globalBackground()
    }
}


#Preview {
    AddStorageLocationView()
        .environmentObject(StorageLocationViewModel())
}
