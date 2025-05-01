//
//  UserRepository.swift
//  FoodHarmony
//
//  Created by Pascal Wiesner on 15.02.25.
//

import FirebaseFirestore

final class UserRepository {
    
    private let database = Firestore.firestore()
    
    func insert(id: String, email: String, createdOn: Date) async throws(Error) -> User {
        let user = User(id: id, email: email, signedUpOn: createdOn)
        
        do {
            try database.collection("users").document(id).setData(from: user)
        } catch {
            throw .creationFailed
        }
        
        return try await find(by: id)
    }
    
    func find(by id: String) async throws(Error) -> User {
        do {
            let snapshot = try await database.collection("users").document(id).getDocument()
            return try snapshot.data(as: User.self)
        } catch {
            throw .fetchingFailed
        }
    }
    
    enum Error: LocalizedError {
        case fetchingFailed
        case creationFailed
        
        var errorDescription: String? {
            switch self {
            case .creationFailed:
                "The user creation failed."
            case .fetchingFailed:
                "The fetching of the user failed."
            }
        }
    }
    
}
