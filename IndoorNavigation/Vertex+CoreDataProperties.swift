//
//  Vertex+CoreDataProperties.swift
//  indoor navigation a


import Foundation
import CoreData


extension Vertex {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Vertex> {
        return NSFetchRequest<Vertex>(entityName: "Vertex")
    }

    @NSManaged public var comment: String?
    @NSManaged public var coordinates: String
    @NSManaged public var id: String
    @NSManaged public var edgefromrelationship: NSOrderedSet?
    @NSManaged public var edgetorelationship: NSOrderedSet?
    @NSManaged public var roomsrelationship: Rooms?

}

// MARK: Generated accessors for edgefromrelationship
extension Vertex {

    @objc(insertObject:inEdgefromrelationshipAtIndex:)
    @NSManaged public func insertIntoEdgefromrelationship(_ value: Edge, at idx: Int)

    @objc(removeObjectFromEdgefromrelationshipAtIndex:)
    @NSManaged public func removeFromEdgefromrelationship(at idx: Int)

    @objc(insertEdgefromrelationship:atIndexes:)
    @NSManaged public func insertIntoEdgefromrelationship(_ values: [Edge], at indexes: NSIndexSet)

    @objc(removeEdgefromrelationshipAtIndexes:)
    @NSManaged public func removeFromEdgefromrelationship(at indexes: NSIndexSet)

    @objc(replaceObjectInEdgefromrelationshipAtIndex:withObject:)
    @NSManaged public func replaceEdgefromrelationship(at idx: Int, with value: Edge)

    @objc(replaceEdgefromrelationshipAtIndexes:withEdgefromrelationship:)
    @NSManaged public func replaceEdgefromrelationship(at indexes: NSIndexSet, with values: [Edge])

    @objc(addEdgefromrelationshipObject:)
    @NSManaged public func addToEdgefromrelationship(_ value: Edge)

    @objc(removeEdgefromrelationshipObject:)
    @NSManaged public func removeFromEdgefromrelationship(_ value: Edge)

    @objc(addEdgefromrelationship:)
    @NSManaged public func addToEdgefromrelationship(_ values: NSOrderedSet)

    @objc(removeEdgefromrelationship:)
    @NSManaged public func removeFromEdgefromrelationship(_ values: NSOrderedSet)

}

// MARK: Generated accessors for edgetorelationship
extension Vertex {

    @objc(insertObject:inEdgetorelationshipAtIndex:)
    @NSManaged public func insertIntoEdgetorelationship(_ value: Edge, at idx: Int)

    @objc(removeObjectFromEdgetorelationshipAtIndex:)
    @NSManaged public func removeFromEdgetorelationship(at idx: Int)

    @objc(insertEdgetorelationship:atIndexes:)
    @NSManaged public func insertIntoEdgetorelationship(_ values: [Edge], at indexes: NSIndexSet)

    @objc(removeEdgetorelationshipAtIndexes:)
    @NSManaged public func removeFromEdgetorelationship(at indexes: NSIndexSet)

    @objc(replaceObjectInEdgetorelationshipAtIndex:withObject:)
    @NSManaged public func replaceEdgetorelationship(at idx: Int, with value: Edge)

    @objc(replaceEdgetorelationshipAtIndexes:withEdgetorelationship:)
    @NSManaged public func replaceEdgetorelationship(at indexes: NSIndexSet, with values: [Edge])

    @objc(addEdgetorelationshipObject:)
    @NSManaged public func addToEdgetorelationship(_ value: Edge)

    @objc(removeEdgetorelationshipObject:)
    @NSManaged public func removeFromEdgetorelationship(_ value: Edge)

    @objc(addEdgetorelationship:)
    @NSManaged public func addToEdgetorelationship(_ values: NSOrderedSet)

    @objc(removeEdgetorelationship:)
    @NSManaged public func removeFromEdgetorelationship(_ values: NSOrderedSet)

}
