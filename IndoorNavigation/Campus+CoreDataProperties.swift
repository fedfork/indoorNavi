//
//  Campus+CoreDataProperties.swift
//  indoor navigation a


import Foundation
import CoreData


extension Campus {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Campus> {
        return NSFetchRequest<Campus>(entityName: "Campus")
    }

    @NSManaged public var comment: String?
    @NSManaged public var id: String
    @NSManaged public var name: String?
    @NSManaged public var buildingsrelationship: NSOrderedSet?

}

// MARK: Generated accessors for buildingsrelationship
extension Campus {

    @objc(insertObject:inBuildingsrelationshipAtIndex:)
    @NSManaged public func insertIntoBuildingsrelationship(_ value: Buildings, at idx: Int)

    @objc(removeObjectFromBuildingsrelationshipAtIndex:)
    @NSManaged public func removeFromBuildingsrelationship(at idx: Int)

    @objc(insertBuildingsrelationship:atIndexes:)
    @NSManaged public func insertIntoBuildingsrelationship(_ values: [Buildings], at indexes: NSIndexSet)

    @objc(removeBuildingsrelationshipAtIndexes:)
    @NSManaged public func removeFromBuildingsrelationship(at indexes: NSIndexSet)

    @objc(replaceObjectInBuildingsrelationshipAtIndex:withObject:)
    @NSManaged public func replaceBuildingsrelationship(at idx: Int, with value: Buildings)

    @objc(replaceBuildingsrelationshipAtIndexes:withBuildingsrelationship:)
    @NSManaged public func replaceBuildingsrelationship(at indexes: NSIndexSet, with values: [Buildings])

    @objc(addBuildingsrelationshipObject:)
    @NSManaged public func addToBuildingsrelationship(_ value: Buildings)

    @objc(removeBuildingsrelationshipObject:)
    @NSManaged public func removeFromBuildingsrelationship(_ value: Buildings)

    @objc(addBuildingsrelationship:)
    @NSManaged public func addToBuildingsrelationship(_ values: NSOrderedSet)

    @objc(removeBuildingsrelationship:)
    @NSManaged public func removeFromBuildingsrelationship(_ values: NSOrderedSet)

}
