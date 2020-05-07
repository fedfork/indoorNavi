//
//  Floors+CoreDataProperties.swift
//  indoor navigation a


import Foundation
import CoreData


extension Floors {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Floors> {
        return NSFetchRequest<Floors>(entityName: "Floors")
    }

    @NSManaged public var comment: String?
    @NSManaged public var id: String
    @NSManaged public var name: String?
    @NSManaged public var buildingsrelationship: Buildings?
    @NSManaged public var roomsrelationship: NSOrderedSet?

}

// MARK: Generated accessors for roomsrelationship
extension Floors {

    @objc(insertObject:inRoomsrelationshipAtIndex:)
    @NSManaged public func insertIntoRoomsrelationship(_ value: Rooms, at idx: Int)

    @objc(removeObjectFromRoomsrelationshipAtIndex:)
    @NSManaged public func removeFromRoomsrelationship(at idx: Int)

    @objc(insertRoomsrelationship:atIndexes:)
    @NSManaged public func insertIntoRoomsrelationship(_ values: [Rooms], at indexes: NSIndexSet)

    @objc(removeRoomsrelationshipAtIndexes:)
    @NSManaged public func removeFromRoomsrelationship(at indexes: NSIndexSet)

    @objc(replaceObjectInRoomsrelationshipAtIndex:withObject:)
    @NSManaged public func replaceRoomsrelationship(at idx: Int, with value: Rooms)

    @objc(replaceRoomsrelationshipAtIndexes:withRoomsrelationship:)
    @NSManaged public func replaceRoomsrelationship(at indexes: NSIndexSet, with values: [Rooms])

    @objc(addRoomsrelationshipObject:)
    @NSManaged public func addToRoomsrelationship(_ value: Rooms)

    @objc(removeRoomsrelationshipObject:)
    @NSManaged public func removeFromRoomsrelationship(_ value: Rooms)

    @objc(addRoomsrelationship:)
    @NSManaged public func addToRoomsrelationship(_ values: NSOrderedSet)

    @objc(removeRoomsrelationship:)
    @NSManaged public func removeFromRoomsrelationship(_ values: NSOrderedSet)

}
