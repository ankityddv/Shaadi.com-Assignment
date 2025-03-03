//
//  HomeViewModel.swift
//  ShaadiComXAnkit
//
//  Created by Ankit Yadav on 22/02/25.
//

import Foundation

class HomeViewModel: ObservableObject {
    
    @Published var matches: [MatchModel] = []
    
    private let homeDataRepository: HomeDataRepository = HomeDataRepository(storage: CoreDataManager(), networkManager: HomeRequestManager())
    
    func fetchMatches() {
        
        homeDataRepository.fetchMatches { [weak self] result in
            
            DispatchQueue.main.async {
                switch result {
                case .success(let fetchedMatches):
                    self?.matches = fetchedMatches
                case .failure(let error):
                    print("Can't fetch matches: \(error)")
                }
            }
        }
    }
    
    func updateMatchStatus(_ match: MatchModel, status: MatchStatus) {
      
        homeDataRepository.updateMatch(match, status: status)
    }
}
