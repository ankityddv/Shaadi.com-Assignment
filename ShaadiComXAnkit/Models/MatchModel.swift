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

struct MatchModel: Identifiable {
    let id: String
    let name: String
    let imageUrl: String
    var status: MatchStatus = .pending
    
    init(from user: UserResponse) {
        self.id = user.login.uuid
        self.name = "\(user.name.first) \(user.name.last)"
        self.imageUrl = user.picture.large
    }
    
    init(from entity: MatchEntity) {
        self.id = entity.id ?? ""
        self.name = entity.name ?? "Unknown"
        self.imageUrl = entity.imageUrl ?? ""
        self.status = MatchStatus(rawValue: entity.status ?? "pending") ?? .pending
    }
}

enum MatchStatus: String {
    case pending, accepted, declined
}
