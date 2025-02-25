//
//  HomeRequestManager.swift
//  ShaadiComXAnkit
//
//  Created by Ankit Yadav on 24/02/25.
//

import Foundation

class HomeRequestManager {
    
    func fetchUsers(completion: @escaping(Result<[MatchModel], Error>) -> Void) {
        
        NetworkManager().getData(url: RANDOM_USER_API_URL) { (result: Result<APIResponse, Error>) in
            
            switch result {
                
            case .success(let response):
                let matches = response.results.map { MatchModel(from: $0) }
                completion(.success(matches))
            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }
}
