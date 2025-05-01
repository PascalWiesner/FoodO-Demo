//
//  addStorageTip.swift
//  FoodO
//
//  Created by Pascal Wiesner on 12.03.25.
//

import TipKit

struct AddStorageTip: Tip{
    
    var title: Text{
        Text("Lagerort erstellen")
    }
    
    var message: Text?{
        Text("Drücke hier um einen Lagerort zu erstellen")
    }
    
    var image: Image?{
        Image(systemName: "plus.app.fill")
    }
}
