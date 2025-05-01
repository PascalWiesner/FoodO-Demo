//
//  RegisterView.swift
//  FoodHarmony
//
//  Created by Pascal Wiesner on 15.02.25.
//

import SwiftUI

struct RegisterView: View {
    
    @EnvironmentObject var user: AuthViewModel
    
    @State private var isPasswordVisible: Bool = false
    @State private var navToLoginView: Bool = false
    @State private var alertLogin = false
    
    var body: some View {
        NavigationStack {
                GeometryReader { geometry in
                    VStack(spacing: 20) {
                        LogoStandart()
                            .padding(.top, 229.5)
                        
                        Spacer(minLength: 50)
                        
                        VStack(spacing: 5) {
                            TextField("", text: $user.email, prompt: Text("E-Mail").foregroundStyle(.white))
                                .TextfieldModifier()
                        }
                        .padding(.horizontal, 10)
                        
                        VStack(spacing: 5) {
                            HStack {
                                if isPasswordVisible {
                                    TextField("", text: $user.password, prompt: Text("Passwort").foregroundStyle(.white))
                                        .SecurefieldModifier()
                                } else {
                                    SecureField("", text: $user.password, prompt: Text("Passwort").foregroundStyle(.white))
                                        .SecurefieldModifier()
                                }
                                
                                Button(action: {
                                    isPasswordVisible.toggle()
                                }) {
                                    Image(systemName: isPasswordVisible ? "eye.slash" : "eye")
                                        .foregroundColor(.white)
                                }
                            }
                            .padding(.bottom, 5)
                            .TextfieldModifier()
                        }
                        .padding(.horizontal, 10)
                        
                        Spacer()
                        
                        CreateButtonMain(buttonText: "Registrieren") {
                            if user.email.isEmpty || user.password.isEmpty {
                                alertLogin = true
                            } else {
                                user.signUp()
                            }
                        }
                        
                        CreateButtonMain(buttonText: "Sie haben bereits einen Account?") {
                            navToLoginView = true
                        }
                        
                        Spacer(minLength: 120)
                        
                   
                        Spacer(minLength: 210)
                    }
                    .frame(height: geometry.size.height)
                    .padding(.horizontal)
                }
                .globalBackground()
            .navigationDestination(isPresented: $navToLoginView) {
                LoginView()
                    .navigationBarHidden(true)
            }
            .alert("Login fehlgeschlagen", isPresented: $alertLogin) {
                Button("OK", role: .cancel) { }
            } message: {
                Text("Bitte überprüfen Sie Ihre Eingaben")
            }
            .ignoresSafeArea(.keyboard, edges: .bottom)
        }
    }
}

#Preview {
    RegisterView()
        .environmentObject(AuthViewModel())
}
