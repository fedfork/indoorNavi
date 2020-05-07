//
//  Poi+CoreDataClass.swift
//  indoor navigation a


import Foundation
import CoreData

@objc(Poi)
public class Poi: NSManagedObject {
    override public class func entity() -> NSEntityDescription {
        return NSEntityDescription.entity(forEntityName: "Poi", in: CoreDataHelper.instance.context)!
    }
    convenience init() {
        self.init(entity: Poi.entity(), insertInto: CoreDataHelper.instance.context)
    }
    convenience init(id: String, coordinates: String?, comment: String?,  image: String?, name: String?, type: Int) {
        self.init()
        self.id = id
        self.coordinates = coordinates!
        self.comment = comment
        self.image = image
        self.name = name
        self.type = Int64(type)
        self.roomsrelationship = nil
    }
    

    /*
     coordinates's format: "0 0"
     coordinates need to have 2 coordinates
     */
    
    class func maximum() -> Int {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Poi")
        
        do {
            let results = try CoreDataHelper.instance.context.fetch(fetchRequest)
            return results.count
        } catch {
            print("I'm here")
            return 1
        }
    }
    class func allitems() -> [Poi] {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Poi")
        
        
        let results = try? CoreDataHelper.instance.context.fetch(
            fetchRequest)
        
        return results as! [Poi]
    }
}
