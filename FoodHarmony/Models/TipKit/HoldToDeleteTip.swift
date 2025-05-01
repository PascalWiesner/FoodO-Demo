//
//  holdToDeleteTip.swift
//  FoodO
//
//  Created by Pascal Wiesner on 12.03.25.
//

import TipKit

struct HoldToDeleteTip: Tip{
   
    var title: Text{
        Text("Drücke um zu löschen")
    }
    
    var message: Text?{
        Text("Drücke länger auf ein Produkt um es zu löschen")
    }
    
    var image: Image?{
        Image(systemName: "trash.fill")
    }
}
