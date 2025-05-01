//
//  FoodDistributionView.swift
//  FoodHarmony
//
//  Created by Pascal Wiesner on 28.02.25.
//

import SwiftUI
import MapKit
import TipKit

struct FoodDistributionView: View {
    
    @EnvironmentObject private var tafelDataBase: TafelDataBase
    @State private var viewModelMapKit = MapViewModel()
    let mapKitMakerTip: MapkitMarkerTip = .init()
    
    var body: some View {
        NavigationStack{
            VStack{
                TipView(mapKitMakerTip)
                Map(position: $viewModelMapKit.cameraPosition){
                    ForEach(tafelDataBase.tafelEVLocations){ tafel in
                        Annotation(tafel.name, coordinate: tafel.coordinate) {
                            Image(systemName: "mappin")
                                .resizable()
                                .scaledToFit()
                                .foregroundStyle(.white)
                                .frame(width: 20, height: 20)
                                .padding(4)
                                .background(Color("appColor"), in: .circle)
                                .contextMenu {
                                    Button("Get Direction") {
                                        Task {
                                            await viewModelMapKit.calculateRoute(destination: tafel.coordinate)
                                        }
                                    }
                                    Button("Look Around Scene") {
                                        Task {
                                            await viewModelMapKit.getLookAroundScene(from: tafel.coordinate)
                                            guard let _ = viewModelMapKit.lookAroundScene else { return }
                                            viewModelMapKit.isShowingLookAroundScene = true
                                        }
                                    }
                                }
                        }
                    }
                    if let route = viewModelMapKit.route {
                        MapPolyline(route.polyline)
                            .stroke(Color("appColor"), lineWidth: 8)
                    }
                }
                .mapStyle(.hybrid)
                .mapControls{
                    MapCompass()
                    MapUserLocationButton()
                    MapScaleView()
                }
            }
            .onAppear {
                viewModelMapKit.requestLocationPermission() 
                   Task {
                       await viewModelMapKit.setUserLocation()
                   }
            }
            .lookAroundViewer(isPresented: $viewModelMapKit.isShowingLookAroundScene, initialScene: viewModelMapKit.lookAroundScene)
        }
    }
}

#Preview {
    FoodDistributionView()
        .environmentObject(TafelDataBase())
}
