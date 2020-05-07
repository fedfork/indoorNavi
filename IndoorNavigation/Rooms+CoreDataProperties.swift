//
//  Rooms+CoreDataProperties.swift
//  indoor navigation a


import Foundation
import CoreData


extension Rooms {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Rooms> {
        return NSFetchRequest<Rooms>(entityName: "Rooms")
    }

    @NSManaged public var comment: String?
    @NSManaged public var id: String
    @NSManaged public var name: String?
    @NSManaged public var polygon: String
    @NSManaged public var type: Int64
    @NSManaged public var beaconsrelationship: NSOrderedSet?
    @NSManaged public var floorsrelationship: Floors?
    @NSManaged public var sessioinrelationship: NSOrderedSet?
    @NSManaged public var vertexrelationship: NSOrderedSet?
    @NSManaged public var poirelationship: NSOrderedSet?
}

// MARK: Generated accessors for beaconsrelationship
extension Rooms {

    @objc(insertObject:inBeaconsrelationshipAtIndex:)
    @NSManaged public func insertIntoBeaconsrelationship(_ value: Beacons, at idx: Int)

    @objc(removeObjectFromBeaconsrelationshipAtIndex:)
    @NSManaged public func removeFromBeaconsrelationship(at idx: Int)

    @objc(insertBeaconsrelationship:atIndexes:)
    @NSManaged public func insertIntoBeaconsrelationship(_ values: [Beacons], at indexes: NSIndexSet)

    @objc(removeBeaconsrelationshipAtIndexes:)
    @NSManaged public func removeFromBeaconsrelationship(at indexes: NSIndexSet)

    @objc(replaceObjectInBeaconsrelationshipAtIndex:withObject:)
    @NSManaged public func replaceBeaconsrelationship(at idx: Int, with value: Beacons)

    @objc(replaceBeaconsrelationshipAtIndexes:withBeaconsrelationship:)
    @NSManaged public func replaceBeaconsrelationship(at indexes: NSIndexSet, with values: [Beacons])

    @objc(addBeaconsrelationshipObject:)
    @NSManaged public func addToBeaconsrelationship(_ value: Beacons)

    @objc(removeBeaconsrelationshipObject:)
    @NSManaged public func removeFromBeaconsrelationship(_ value: Beacons)

    @objc(addBeaconsrelationship:)
    @NSManaged public func addToBeaconsrelationship(_ values: NSOrderedSet)

    @objc(removeBeaconsrelationship:)
    @NSManaged public func removeFromBeaconsrelationship(_ values: NSOrderedSet)

}

// MARK: Generated accessors for sessioinrelationship
extension Rooms {
//
//    @objc(insertObject:inSessioinrelationshipAtIndex:)
//    @NSManaged public func insertIntoSessioinrelationship(_ value: Session, at idx: Int)
//
//    @objc(removeObjectFromSessioinrelationshipAtIndex:)
//    @NSManaged public func removeFromSessioinrelationship(at idx: Int)
//
//    @objc(insertSessioinrelationship:atIndexes:)
//    @NSManaged public func insertIntoSessioinrelationship(_ values: [Session], at indexes: NSIndexSet)
//
//    @objc(removeSessioinrelationshipAtIndexes:)
//    @NSManaged public func removeFromSessioinrelationship(at indexes: NSIndexSet)
//
//    @objc(replaceObjectInSessioinrelationshipAtIndex:withObject:)
//    @NSManaged public func replaceSessioinrelationship(at idx: Int, with value: Session)
//
//    @objc(replaceSessioinrelationshipAtIndexes:withSessioinrelationship:)
//    @NSManaged public func replaceSessioinrelationship(at indexes: NSIndexSet, with values: [Session])
//
//    @objc(addSessioinrelationshipObject:)
//    @NSManaged public func addToSessioinrelationship(_ value: Session)
//
//    @objc(removeSessioinrelationshipObject:)
//    @NSManaged public func removeFromSessioinrelationship(_ value: Session)
//
//    @objc(addSessioinrelationship:)
//    @NSManaged public func addToSessioinrelationship(_ values: NSOrderedSet)
//
//    @objc(removeSessioinrelationship:)
//    @NSManaged public func removeFromSessioinrelationship(_ values: NSOrderedSet)

}

// MARK: Generated accessors for vertexrelationship
extension Rooms {

    @objc(insertObject:inVertexrelationshipAtIndex:)
    @NSManaged public func insertIntoVertexrelationship(_ value: Vertex, at idx: Int)

    @objc(removeObjectFromVertexrelationshipAtIndex:)
    @NSManaged public func removeFromVertexrelationship(at idx: Int)

    @objc(insertVertexrelationship:atIndexes:)
    @NSManaged public func insertIntoVertexrelationship(_ values: [Vertex], at indexes: NSIndexSet)

    @objc(removeVertexrelationshipAtIndexes:)
    @NSManaged public func removeFromVertexrelationship(at indexes: NSIndexSet)

    @objc(replaceObjectInVertexrelationshipAtIndex:withObject:)
    @NSManaged public func replaceVertexrelationship(at idx: Int, with value: Vertex)

    @objc(replaceVertexrelationshipAtIndexes:withVertexrelationship:)
    @NSManaged public func replaceVertexrelationship(at indexes: NSIndexSet, with values: [Vertex])

    @objc(addVertexrelationshipObject:)
    @NSManaged public func addToVertexrelationship(_ value: Vertex)

    @objc(removeVertexrelationshipObject:)
    @NSManaged public func removeFromVertexrelationship(_ value: Vertex)

    @objc(addVertexrelationship:)
    @NSManaged public func addToVertexrelationship(_ values: NSOrderedSet)

    @objc(removeVertexrelationship:)
    @NSManaged public func removeFromVertexrelationship(_ values: NSOrderedSet)

}
