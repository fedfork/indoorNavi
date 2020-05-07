//
//  Vertex+CoreDataClass.swift
//  TableData


import Foundation
import CoreData

@objc(Vertex)
public class Vertex: NSManagedObject {
    override public class func entity() -> NSEntityDescription {
        return NSEntityDescription.entity(forEntityName: "Vertex", in: CoreDataHelper.instance.context)!
    }
    convenience init() {
        self.init(entity: Vertex.entity(), insertInto: CoreDataHelper.instance.context)
    }
    convenience init(id: String, coordinates: String?, comment: String?) {
        self.init()
        self.id = id
        self.coordinates = coordinates!
        self.comment = comment
        self.edgefromrelationship = nil
        self.edgetorelationship = nil
        self.roomsrelationship = nil
    }
    

    /*
     coordinates's format: "0 0"
     coordinates need to have 2 coordinates
     */
    
    class func maximum() -> Int {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Vertex")
        
        do {
            let results = try CoreDataHelper.instance.context.fetch(fetchRequest)
            return results.count
        } catch {
            print("I'm here")
            return 1
        }
    }
    class func allitems() -> [Vertex] {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Vertex")
        
        
        let results = try? CoreDataHelper.instance.context.fetch(
            fetchRequest)
        
        return results as! [Vertex]
    }
}
