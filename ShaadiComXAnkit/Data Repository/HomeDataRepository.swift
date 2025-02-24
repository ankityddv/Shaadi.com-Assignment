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
                self?.storageManager.saveMatches(success)
            case .failure(let failure):
                print("failed to fetch data")
            }
            
            completion(result)
        }
    }
    
    func updateMatch(_ match: MatchModel, status: MatchStatus, completion: @escaping ([MatchModel]) -> Void) {
        storageManager.updateMatch(match, status: status)
        completion(storageManager.fetchStoredMatches())
    }
}
