//
//  ProductItemRepository.swift
//  FoodHarmony
//
//  Created by Pascal Wiesner on 20.02.25.
//


import FirebaseFirestore

final class ProductItemRepository {
    
    private let collection = Firestore.firestore().collection("scannedProducts")
    
    func insert(name: String, image: String,  isComplete: Bool = false, date: Date, storageLocationID: String, ecoScoreGrade: String) throws(Error) {
        guard let creatorID = AuthManager.shared.userID else {
            throw .notAuthenticated
        }
        
        let product = ProductItem(creatorID: creatorID, name: name, image3: image, isComplete: isComplete, expirationDate: date, storageLocationId: storageLocationID, ecoScoreGrade: ecoScoreGrade)
        do {
            try collection.addDocument(from: product)
        } catch {
            throw .failedCreation(reason: error.localizedDescription)
        }
    }
    
    func observe(onChange: @escaping ([ProductItem]) -> Void) throws(Error) {
        guard let creatorID = AuthManager.shared.userID else {
            throw .notAuthenticated
        }
        collection.whereField("creatorID", isEqualTo: creatorID).addSnapshotListener(includeMetadataChanges: false) { snapshot, error in
            if error != nil { return }
            guard let snapshot = snapshot else { return }
            
            let productItems = snapshot.documents.compactMap { document in
                try? document.data(as: ProductItem.self)
            }
            
            onChange(productItems)
        }
    }
    
    func findAll(byCreator id: String) async throws(Error) -> [ProductItem] {
        do {
            let documents = try await collection.whereField("creatorID", isEqualTo: id).getDocuments()
            let tasks = documents.documents.compactMap { document in
                try? document.data(as: ProductItem.self)
            }
            return tasks
        } catch {
            throw .findAllFailed(reason: error.localizedDescription)
        }
    }
    
    func find(by id: String) async throws(Error) -> ProductItem {
        do {
            return try await collection.document(id).getDocument().data(as: ProductItem.self)
        } catch {
            throw .failedFinding(reason: error.localizedDescription)
        }
    }
    
    func updateIsComplete(by id: ProductItem.ID, isComplete: Bool) async throws(Error) {
        guard let id = id else { throw .noTaskID }
        let updateData = ["isComplete": isComplete]
        do {
            try await collection.document(id).updateData(updateData)
        } catch {
            throw .failedUpdating(reason: error.localizedDescription)
        }
    }
    
    func update(productItem: ProductItem) throws(Error) {
        guard let taskID = productItem.id else { throw .noTaskID }
        do {
            try collection.document(taskID).setData(from: productItem)
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
    
    func fetchProducts(for storageLocationId: String) async throws -> [ProductItem] {
          do {
              let documents = try await collection.whereField("storageLocationId", isEqualTo: storageLocationId).getDocuments()
              return documents.documents.compactMap { document in
                  try? document.data(as: ProductItem.self)
              }
          } catch {
              throw Error.findAllFailed(reason: error.localizedDescription)
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
