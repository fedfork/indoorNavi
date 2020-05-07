//
//  Beacons+CoreDataProperties.swift
//  indoor navigation a

import Foundation
import CoreData


extension Beacons {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Beacons> {
        return NSFetchRequest<Beacons>(entityName: "Beacons")
    }

    @NSManaged public var comment: String?
    @NSManaged public var coordinates: String
    @NSManaged public var height: String?
    @NSManaged public var id: String
    @NSManaged public var majorminor: String
    @NSManaged public var name: String?
    @NSManaged public var uuid: String
    @NSManaged public var roomsrelationship: Rooms?

}
