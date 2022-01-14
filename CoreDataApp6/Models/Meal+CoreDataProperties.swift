//
//  Meal+CoreDataProperties.swift
//  CoreDataApp6
//
//  Created by Eugene on 14.01.2022.
//
//

import Foundation
import CoreData


extension Meal {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Meal> {
        return NSFetchRequest<Meal>(entityName: "Meal")
    }

    @NSManaged public var date: Date?
    @NSManaged public var person: Person?

}

extension Meal : Identifiable {

}
