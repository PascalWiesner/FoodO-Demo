//
//  TafelEVDataBase.swift
//  FoodHarmony
//
//  Created by Pascal Wiesner on 28.02.25.
//

import Foundation
import MapKit

struct TafelEV: Identifiable{
    
    let id = UUID()
    let name: String
    let coordinate: CLLocationCoordinate2D
    
}
