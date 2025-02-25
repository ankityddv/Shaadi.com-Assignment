//
//  CoreDataManager.swift
//  ShaadiComXAnkit
//
//  Created by Ankit Yadav on 22/02/25.
//

import CoreData

protocol StorageProtocol {
    func saveMatches(_ matches: [MatchModel])
    func fetchStoredMatches() -> [MatchModel]
    func updateMatch(_ match: MatchModel, status: MatchStatus)
}

class CoreDataManager: StorageProtocol {
    
    static let shared = CoreDataManager()
    private let context = PersistenceController.shared.container.viewContext
    
    func saveMatches(_ matches: [MatchModel]) {
       
        do {
        
            for match in matches {
            
                let entity = MatchEntity(context: context)
                entity.id = match.id
                entity.name = match.name
                entity.imageUrl = match.imageUrl
                entity.statusInt = match.statusInt
            }
            
            try context.save()
        } catch {
            print("Failed to save matches: \(error)")
        }
    }
    
    func fetchStoredMatches() -> [MatchModel] {
        
        let request: NSFetchRequest<MatchEntity> = MatchEntity.fetchRequest()
        
        do {
            return try context.fetch(request).map { MatchModel(from: $0) }
        } catch {
            print("Failed to fetch matches: \(error)")
            return []
        }
    }
    
    func updateMatch(_ match: MatchModel, status: MatchStatus) {
        
        let request: NSFetchRequest<MatchEntity> = MatchEntity.fetchRequest()
        request.predicate = NSPredicate(format: "id == %@", match.id)
        
        do {
        
            let results = try context.fetch(request)
            
            if let entity = results.first {
                entity.statusInt = status.rawValue
                try context.save()
            } else {
                let newEntity = MatchEntity(context: context)
                newEntity.id = match.id
                newEntity.name = match.name
                newEntity.imageUrl = match.imageUrl
                newEntity.statusInt = status.rawValue
                try context.save()
            }
        } catch {
            print("Failed to update match: \(error)")
        }
    }
}
