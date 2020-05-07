//
//  Buildings+CoreDataProperties.swift
//  indoor navigation a

import Foundation
import CoreData


extension Buildings {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Buildings> {
        return NSFetchRequest<Buildings>(entityName: "Buildings")
    }

    @NSManaged public var adress: String?
    @NSManaged public var comment: String?
    @NSManaged public var id: String
    @NSManaged public var name: String?
    @NSManaged public var campusrelationship: Campus?
    @NSManaged public var floorsrelationship: NSOrderedSet?

}

// MARK: Generated accessors for floorsrelationship
extension Buildings {

    @objc(insertObject:inFloorsrelationshipAtIndex:)
    @NSManaged public func insertIntoFloorsrelationship(_ value: Floors, at idx: Int)

    @objc(removeObjectFromFloorsrelationshipAtIndex:)
    @NSManaged public func removeFromFloorsrelationship(at idx: Int)

    @objc(insertFloorsrelationship:atIndexes:)
    @NSManaged public func insertIntoFloorsrelationship(_ values: [Floors], at indexes: NSIndexSet)

    @objc(removeFloorsrelationshipAtIndexes:)
    @NSManaged public func removeFromFloorsrelationship(at indexes: NSIndexSet)

    @objc(replaceObjectInFloorsrelationshipAtIndex:withObject:)
    @NSManaged public func replaceFloorsrelationship(at idx: Int, with value: Floors)

    @objc(replaceFloorsrelationshipAtIndexes:withFloorsrelationship:)
    @NSManaged public func replaceFloorsrelationship(at indexes: NSIndexSet, with values: [Floors])

    @objc(addFloorsrelationshipObject:)
    @NSManaged public func addToFloorsrelationship(_ value: Floors)

    @objc(removeFloorsrelationshipObject:)
    @NSManaged public func removeFromFloorsrelationship(_ value: Floors)

    @objc(addFloorsrelationship:)
    @NSManaged public func addToFloorsrelationship(_ values: NSOrderedSet)

    @objc(removeFloorsrelationship:)
    @NSManaged public func removeFromFloorsrelationship(_ values: NSOrderedSet)

}
