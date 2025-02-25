//
//  MatchEntity+CoreDataProperties.swift
//  ShaadiComXAnkit
//
//  Created by Ankit Yadav on 25/02/25.
//
//

import Foundation
import CoreData


extension MatchEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MatchEntity> {
        return NSFetchRequest<MatchEntity>(entityName: "MatchEntity")
    }

    @NSManaged public var id: String?
    @NSManaged public var name: String?
    @NSManaged public var imageUrl: String?
    @NSManaged public var statusInt: Int

}

extension MatchEntity : Identifiable {

}
