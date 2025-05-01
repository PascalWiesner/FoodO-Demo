//
//  FAQView.swift
//  FoodHarmony
//
//  Created by Pascal Wiesner on 07.03.25.
//

import SwiftUI

struct FAQView: View {
    var body: some View {
        
        
        VStack{
            ScrollView(){
                VStack(){
                    Text("Wie ist die Einordnung der Produkte im MHD?")
                        .font(.system(size: 20))
                        .bold()
                        .padding()
                    
                    Text("Eine rote Umrandung beutet: Das Produkt ist noch 3 Tage haltbar\n\n Eine gelbe Umrandung beutet: Das Produkt ist noch 4-10 Tage haltbar\n\nEine Grüne Umrandung beutet: Das Produkt ist länger als 10 Tage haltbar\n\n")
                        .font(.system(size: 15))
                        .padding()
                }
                .FAQContainerModifier()
                VStack{
                    Text("Wie lösche ich ein Produkt?")
                        .font(.system(size: 20))
                        .bold()
                        .padding()
                    Text("Ein Produkt können sie löschen, indem sie länger auf ein Product draufklicken. Dann öffnet sich ein Menü wo sie auf löschen klicken können\n\n")
                        .font(.system(size: 15))
                        .padding()
                }
                .FAQContainerModifier()
                VStack{
                    Text("Wo kann ich sehen wann mein Produkt abläuft?")
                        .font(.system(size: 20))
                        .bold()
                        .padding()
                    Text("Wenn sie einmal auf ein Produkt tippen, kommen sie in die Detailansicht, dort steht dann das Mindesthaltbarkeitsdatum\n\n")
                        .font(.system(size: 15))
                        .padding()
                }
                .FAQContainerModifier()
                VStack{
                    Text("Kann ich auch schauen, wie sehr mein Produkt die Umwelt belastet?")
                        .font(.system(size: 20))
                        .bold()
                        .padding()
                    Text("Natürlich! anhand der Umweltskala in der Detailansicht ihres Produkts können sie sehen wie sich ihr Produkt auf die Umwelt auswirkt. Sollte die Skala keine Umrandung aufweisen, dann ist diese leider noch nicht in der Datenbank erfasst\n\n")
                        .font(.system(size: 15))
                        .padding()
                }
                .FAQContainerModifier()
                VStack{
                    Text("Woher weiß ich ob der Scanner das Produkt richtig gescannt hat?")
                        .font(.system(size: 20))
                        .bold()
                        .padding()
                    Text("Wenn der Scanner ihnen >>Produkt nicht gefunden<< anzeigt, dann ist das Produkt noch nicht in der Datenbank, sobald sie ein Produkt scannen und dieses gefunden wird, springt dieser um und zeigt das Produkt an.\n\n")
                        .font(.system(size: 15))
                        .padding()
                }
                .FAQContainerModifier()
            }
            .padding()
        }
        .foregroundStyle(.white)
        .background(.black)
        .scrollIndicators(.hidden)
    }
}

#Preview {
    FAQView()
}
