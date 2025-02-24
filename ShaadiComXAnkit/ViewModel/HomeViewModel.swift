//
//  HomeViewModel.swift
//  ShaadiComXAnkit
//
//  Created by Ankit Yadav on 22/02/25.
//

import Foundation

class HomeViewModel: ObservableObject {
    
    @Published var matches: [MatchModel] = []
    
    private let networkManager = NetworkManager()
    private let coreDataManager = CoreDataManager()
    
    func fetchMatches() {
        
        networkManager.fetchMatches { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let fetchedMatches):
                    self.matches = fetchedMatches
                    self.coreDataManager.saveMatches(fetchedMatches)
                case .failure(let error):
                    print("Error fetching matches: \(error)")
                    self.matches = self.coreDataManager.fetchStoredMatches()
                }
            }
        }
    }
    
    func updateMatchStatus(_ match: MatchModel, status: MatchStatus) {
        coreDataManager.updateMatch(match, status: status)
        matches = coreDataManager.fetchStoredMatches()
    }
}
