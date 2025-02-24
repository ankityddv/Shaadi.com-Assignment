//
//  MatchModel.swift
//  ShaadiComXAnkit
//
//  Created by Ankit Yadav on 22/02/25.
//

import Foundation

struct APIResponse: Codable {
    let results: [UserResponse]
}

struct UserResponse: Codable {
    let name: Name
    let picture: Picture
    let login: Login
}

struct Name: Codable {
    let first: String
    let last: String
}

struct Picture: Codable {
    let large: String
}

struct Login: Codable {
    let uuid: String
}

struct MatchModel: Identifiable, Codable {
    
    let id: String
    let name: String
    let imageUrl: String
    var statusInt: Int
    
    init(from user: UserResponse) {
        self.id = user.login.uuid
        self.name = "\(user.name.first) \(user.name.last)"
        self.imageUrl = user.picture.large
        self.statusInt = 2
    }
    
    enum CodingKeys: String, CodingKey {
        case id, name, imageUrl, statusInt
    }
    
//    init(from entity: MatchEntity) {
//        self.id = entity.id ?? ""
//        self.name = entity.name ?? "Unknown"
//        self.imageUrl = entity.imageUrl ?? ""
//        self.status = MatchStatus(rawValue: entity.status ?? "pending") ?? .pending
//    }
}
extension MatchModel {
   
    var status: MatchStatus {
        get {
            return MatchStatus(rawValue: statusInt)!
        }
        set {
            statusInt = newValue.rawValue
        }
    }
}

enum MatchStatus: Int, Codable {
    
    case pending = 2
    case accepted = 1
    case declined = 0
}
