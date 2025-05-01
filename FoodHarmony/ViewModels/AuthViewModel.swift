//
//  AuthViewModel.swift
//  FoodHarmony
//
//  Created by Pascal Wiesner on 15.02.25.
//

import Combine
import Foundation

@MainActor
final class AuthViewModel: ObservableObject {
    
    @Published var user: User?
    @Published var errorMessage: String?
    @Published var isSignUpSuccessful: Bool = false
    @Published var isSignInSuccessful: Bool = false    
    @Published var email: String = ""
    @Published var password: String = ""
    
    private let userRepository = UserRepository()
    
    var isUserSignedIn: Bool {
        AuthManager.shared.isUserSignedIn
    }

    func signOut() {
        Task {
            try? AuthManager.shared.signOut()
            user = nil
        }
    }
    
    func signUp() {
        Task {
            do {
                try await AuthManager.shared.signUp(email: email, password: password)
                let userID = AuthManager.shared.userID!
                let email = AuthManager.shared.email!
                self.user = try await userRepository.insert(id: userID, email: email, createdOn: .now)
                errorMessage = nil
                isSignUpSuccessful = true
            } catch {
                errorMessage = error.localizedDescription
                isSignUpSuccessful = false
            }
        }
    }
    
    func signIn() {
        Task {
            do {
                try await AuthManager.shared.signIn(email: email, password: password)
                let userID = AuthManager.shared.userID!
                user = try await userRepository.find(by: userID)
                errorMessage = nil
                isSignInSuccessful = true
            } catch {
                errorMessage = error.localizedDescription
                isSignInSuccessful = false
            }
        }
    }
    
    init() {
        _ = AuthManager.shared
        fetchCurrentUser()
    }
    
    private func fetchCurrentUser() {
        Task {
            do {
                if let userID = AuthManager.shared.userID {
                    user = try await userRepository.find(by: userID)
                }
            } catch {
                errorMessage = "The user is not signed in."
            }
        }
    }
}
