//
//  ShoppingListRepository.swift
//  FoodHarmony
//
//  Created by Pascal Wiesner on 04.03.25.
//

import FirebaseFirestore

final class ShoppingListRepository{
    
    private let collection = Firestore.firestore().collection("shoppingListItems")
    
    func insert(name: String) throws(Error) {
        guard let creatorID = AuthManager.shared.userID else {
            throw .notAuthenticated
        }
        
        let shoppingItem = ShoppingItem(creatorID: creatorID, name: name)
        
        do{
            try collection.addDocument(from: shoppingItem)
        }
        catch{
            throw.failedCreation(reason: error.localizedDescription)
        }
    }
        func Observe(onChange: @escaping ([ShoppingItem]) -> Void) throws(Error){
            guard let creatorID = AuthManager.shared.userID else {
                throw .notAuthenticated
            }
            
            collection.whereField("creatorID", isEqualTo: creatorID).addSnapshotListener(includeMetadataChanges: false){ snapshot, error in
                if error != nil {return}
                
                guard let snapshot = snapshot else { return }
                
                let shoppingItems = snapshot.documents.compactMap{ document in
                    try? document.data(as: ShoppingItem.self)
                }
                
                onChange(shoppingItems)
            }
        }
    
    func delete(by id: String) async throws(Error){
        do{
            try await collection.document(id).delete()
        } catch{
            throw.failedDeleting(reason: error.localizedDescription)
        }
    }
    
    func updateCheckmark(shoppingItem: ShoppingItem) async throws(Error) {
          guard let id = shoppingItem.id else {
              throw Error.noTaskID
          }
          do {
              try collection.document(id).setData(from: shoppingItem)
          } catch {
              throw Error.failedUpdating(reason: error.localizedDescription)
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
            switch self{
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


