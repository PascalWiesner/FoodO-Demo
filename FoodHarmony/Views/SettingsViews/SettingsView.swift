//
//  SettingsView.swift
//  FoodHarmony
//
//  Created by Pascal Wiesner on 27.02.25.
//

import SwiftUI

struct SettingsView: View {
    
    @EnvironmentObject var user: AuthViewModel
    @State private var navToFAQView = false
    @State private var navToLicenseView = false
    @State private var navToAboutUsView = false
    @State private var navToContactView = false
    
    var body: some View {
        
        NavigationStack{
            VStack(spacing: 40){
                LogoSettings()
                HStack(spacing: 40){
                    CreateSettingsButton(buttonText: "FAQ") {
                        navToFAQView = true
                    }
                    
                    CreateSettingsButton(buttonText: "Kontakt") {
                        navToContactView = true
                    }
                }
                
                HStack(spacing: 40){
                    CreateSettingsButton(buttonText: "Über uns") {
                        navToAboutUsView = true
                    }
                    CreateSettingsButton(buttonText: "Lizenz") {
                        navToLicenseView = true
                    }
                }
                CreateLogoutButtonSettings(buttonText: "Logout", buttonAction: {
                    user.signOut()
                })
                
            }
            .padding(.bottom, 30)
            .globalBackground()
            .sheet(isPresented: $navToFAQView) {
                FAQView()
                    .presentationDragIndicator(.visible)
                }
            .sheet(isPresented: $navToLicenseView) {
                LicenseView()
                    .presentationDragIndicator(.visible)
                }
            .sheet(isPresented: $navToAboutUsView) {
                AboutUsView()
                    .presentationDragIndicator(.visible)
                }
            .sheet(isPresented: $navToContactView) {
                ContactView()
                    .presentationDragIndicator(.visible)
                }
            .navigationTitle("Einstellungen")
            .navigationBarTitleDisplayMode(.inline)
            }
        }
    }


#Preview {
    SettingsView()
}
