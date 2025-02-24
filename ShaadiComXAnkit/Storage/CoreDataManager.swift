//
//  CoreDataManager.swift
//  ShaadiComXAnkit
//
//  Created by Ankit Yadav on 22/02/25.
//

import CoreData

class CoreDataManager {
    
    let context = PersistenceController.shared.container.viewContext
    
    func saveMatches(_ matches: [MatchModel]) {
        do {
            for match in matches {
                let entity = MatchEntity(context: context)
                entity.id = match.id
                entity.name = match.name
                entity.imageUrl = match.imageUrl
                entity.status = match.status.rawValue
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
                entity.status = status.rawValue
                try context.save()
            }
        } catch {
            print("Failed to update match: \(error)")
        }
    }
}
