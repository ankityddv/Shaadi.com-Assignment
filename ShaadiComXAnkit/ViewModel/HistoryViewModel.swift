//
//  HistoryViewModel.swift
//  ShaadiComXAnkit
//
//  Created by Ankit Yadav on 24/02/25.
//

import Foundation

class HistoryViewModel: ObservableObject {
    
    @Published var history: [MatchModel] = []
    
    func fetchMatches(storage: StorageProtocol) {
        
        self.history = storage.fetchStoredMatches()
    }
}
