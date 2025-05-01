//
//  Login View.swift
//  FoodHarmony
//
//  Created by Pascal Wiesner on 14.02.25.
//

import SwiftUI

struct LoginView: View {
    
    @EnvironmentObject var user: AuthViewModel
    
    @State private var isPasswordVisible: Bool = false
    @State private var navToRegister: Bool = false
    @State private var alertLogin = false
    
    var body: some View {
        NavigationStack {
                GeometryReader { geometry in
                    VStack(spacing: 20) {
                        LogoStandart()
                            .padding(.top, 200)
                        
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
                                        .foregroundStyle(.white)
                                }
                            }
                            .padding(.bottom, 5)
                            .TextfieldModifier()
                        }
                        .padding(.horizontal, 10)
                        
                        Spacer()
                        
                        CreateButtonMain(buttonText: "Login") {
                            if user.email.isEmpty || user.password.isEmpty {
                                alertLogin = true
                            } else {
                                user.signIn()
                            }
                        }
                        
                        Spacer(minLength: 140)
                        
                        Button {
                            navToRegister = true
                        } label: {
                            Text("Neu hier? Hier registrieren")
                                .foregroundStyle(.white)
                        }
                        Spacer(minLength: 190)
                    }
                    .frame(height: geometry.size.height)
                    .padding(.horizontal)
                }
                .globalBackground()
            .navigationDestination(isPresented: $navToRegister) {
                RegisterView()
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
    LoginView()
        .environmentObject(AuthViewModel())
}
