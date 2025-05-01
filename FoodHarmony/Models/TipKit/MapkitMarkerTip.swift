//
//  MapkitMarkerTip.swift
//  FoodO
//
//  Created by Pascal Wiesner on 12.03.25.
//

import TipKit

struct MapkitMarkerTip: Tip{
   
    var title: Text{
        Text("Route/Ansicht")
    }
    
    var message: Text?{
        Text("Drücke auf einen Marker um zu dem Standort zu navigieren oder eine 3D Ansicht der Karte zu erhalten")
    }
    
    var image: Image?{
        Image(systemName: "mappin.circle.fill")
    }
}
