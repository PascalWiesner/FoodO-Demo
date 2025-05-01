//
//  ShoppingListTip.swift
//  FoodO
//
//  Created by Pascal Wiesner on 12.03.25.
//

import TipKit

struct ShoppingListTip: Tip{
   
    var title: Text{
        Text("Einkaufsliste")
    }
    
    var message: Text?{
        Text("Klicke hier um in die Einkaufsliste zu gelangen")
    }
    
    var image: Image?{
        Image(systemName: "cart")
    }
}
