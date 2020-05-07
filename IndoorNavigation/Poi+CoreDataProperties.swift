//
//  Poi+CoreDataProperties.swift
//  indoor navigation a


import Foundation
import CoreData


extension Poi {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Poi> {
        return NSFetchRequest<Poi>(entityName: "Poi")
    }

    @NSManaged public var coordinates: String
    @NSManaged public var type: Int64
    @NSManaged public var name: String?
    @NSManaged public var comment: String?
    @NSManaged public var image: String?
    @NSManaged public var id: String
    @NSManaged public var roomsrelationship: Rooms?

}
