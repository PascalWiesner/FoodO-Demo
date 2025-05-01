//
//  StorageLocationRepository.swift
//  FoodHarmony
//
//  Created by Pascal Wiesner on 24.02.25.
//

import FirebaseFirestore

final class StorageLocationRepository {
    
    private let collection = Firestore.firestore().collection("storageLocations")
    
    func insert(name: String, symbol: String) throws(Error) {
        guard let creatorID = AuthManager.shared.userID else {
            throw .notAuthenticated
        }
        
        let storageLocation = StorageLocation(creatorID: creatorID, name: name, symbol: symbol)
        
        do {
            try collection.addDocument(from: storageLocation)
        } catch {
            throw .failedCreation(reason: error.localizedDescription)
        }
    }
    
    func observe(onChange: @escaping ([StorageLocation]) -> Void) throws(Error) {
        guard let creatorID = AuthManager.shared.userID else {
            throw .notAuthenticated
        }
        collection.whereField("creatorID", isEqualTo: creatorID).addSnapshotListener(includeMetadataChanges: false) { snapshot, error in
            if error != nil { return }
            guard let snapshot = snapshot else { return }
            
            let storageLocations = snapshot.documents.compactMap { document in
                try? document.data(as: StorageLocation.self)
            }
            
            onChange(storageLocations)
        }
    }
    
    func findAll(byCreator id: String) async throws(Error) -> [StorageLocation] {
        do {
            let documents = try await collection.whereField("creatorID", isEqualTo: id).getDocuments()
            let tasks = documents.documents.compactMap { document in
                try? document.data(as: StorageLocation.self)
            }
            return tasks
        } catch {
            throw .findAllFailed(reason: error.localizedDescription)
        }
    }
    
    func find(by id: String) async throws(Error) -> StorageLocation {
        do {
            return try await collection.document(id).getDocument().data(as: StorageLocation.self)
        } catch {
            throw .failedFinding(reason: error.localizedDescription)
        }
    }
    
    func update(storageLocation: StorageLocation) throws(Error) {
        guard let taskID = storageLocation.id else { throw .noTaskID }
        do {
            try collection.document(taskID).setData(from: storageLocation)
        } catch {
            throw .failedUpdating(reason: error.localizedDescription)
        }
    }
    
    func delete(by id: String) async throws(Error) {
        do {
            try await collection.document(id).delete()
        } catch {
            throw .failedDeleting(reason: error.localizedDescription)
        }
    }
    
    enum Error: LocalizedError {
        case notAuthenticated
        case noTaskID
        case failedCreation(reason: String)
        case failedFinding(reason: String)
        case failedDeleting(reason: String)
        case failedUpdating(reason: String)
        case findAllFailed(reason: String)
        
        var errorDescription: String? {
            switch self {
            case .notAuthenticated:
                "You are not authenticated."
            case .noTaskID:
                "The task does not exist yet."
            case .failedCreation(let reason):
                "The task could not be created: \(reason)"
            case .failedFinding(let reason):
                "The task could not be found: \(reason)"
            case .failedDeleting(let reason):
                "The task could not be deleted: \(reason)"
            case .failedUpdating(let reason):
                "The task could not be updated: \(reason)"
            case .findAllFailed(let reason):
                "Your tasks could not be loaded: \(reason)"
            }
        }
    }
    
}

