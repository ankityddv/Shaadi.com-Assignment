//
//  PersistenceController.swift
//  ShaadiComXAnkit
//
//  Created by Ankit Yadav on 22/02/25.
//

import CoreData

class PersistenceController {
    
    static let shared = PersistenceController()
    
    let container: NSPersistentContainer
    
    init() {
       
        container = NSPersistentContainer(name: "MatchModel")
        container.loadPersistentStores { _, error in
            if let error = error {
                fatalError("Unresolved error \(error)")
            }
        }
    }
}
