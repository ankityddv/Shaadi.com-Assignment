//
//  NetworkManager.swift
//  ShaadiComXAnkit
//
//  Created by Ankit Yadav on 22/02/25.
//

import Foundation

protocol NetworkRequestProtocol {
    func getData<T>(url: String, completion: @escaping (Result<[T], any Error>) -> Void)
}

class NetworkManager: NetworkRequestProtocol {
    
    func getData<T>(url: String, completion: @escaping (Result<[T], any Error>) -> Void) {
       
        guard let url = URL(string: url) else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "Invalid Data", code: 0)))
                return
            }
            
            do {
                let response = try JSONDecoder().decode(APIResponse.self, from: data)
                let matches = response.results.map { MatchModel(from: $0) }
                completion(.success(matches))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}

class HomeRequestManager {
    
    func fetchUsers() -> [MatchModel] {
        
        NetworkManager().getData(url: "https://randomuser.me/api/?results=10", completion: <#T##(Result<[T], any Error>) -> Void#>)
    }
        
}
