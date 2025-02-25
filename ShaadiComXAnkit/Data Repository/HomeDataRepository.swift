//
//  HomeDataRepository.swift
//  ShaadiComXAnkit
//
//  Created by Ankit Yadav on 24/02/25.
//

import Foundation

class HomeDataRepository {
    
    private var storageManager: StorageProtocol
    private let networkManager: HomeRequestManager
    
    init(storage: StorageProtocol, networkManager: HomeRequestManager) {
        self.storageManager = storage
        self.networkManager = networkManager
    }
    
    func fetchMatches(completion: @escaping(Result<[MatchModel], Error>) -> Void) {
        
        self.networkManager.fetchUsers { [weak self] result in
            switch result {
            case .success(let success):
                completion(.success(success))
            case .failure(let failure):
                print("failed to fetch data: \(failure)")
                // send matches from the cache
                completion(.success(self?.storageManager.fetchStoredMatches() ?? []))
            }
        }
    }
    
    func updateMatch(_ match: MatchModel, status: MatchStatus) {
        storageManager.updateMatch(match, status: status)
    }
}
