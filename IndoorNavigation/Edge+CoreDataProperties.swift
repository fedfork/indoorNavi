//
//  Edge+CoreDataProperties.swift
//  indoor navigation a


import Foundation
import CoreData


extension Edge {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Edge> {
        return NSFetchRequest<Edge>(entityName: "Edge")
    }

    @NSManaged public var comment: String?
    @NSManaged public var distance: String
    @NSManaged public var doorscoordinates: String
    @NSManaged public var id: String
    @NSManaged public var vertexfrom: String
    @NSManaged public var vertexto: String
    @NSManaged public var vertexfromrelationship: Vertex?
    @NSManaged public var vertextorelationship: Vertex?

}
