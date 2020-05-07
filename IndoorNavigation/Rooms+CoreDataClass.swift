//
//  Rooms+CoreDataClass.swift
//  TableData

import Foundation
import CoreData

@objc(Rooms)
public class Rooms: NSManagedObject {
    override public class func entity() -> NSEntityDescription {
        return NSEntityDescription.entity(forEntityName: "Rooms", in: CoreDataHelper.instance.context)!
    }
    convenience init() {
        self.init(entity: Rooms.entity(), insertInto: CoreDataHelper.instance.context)
    }
    convenience init(id: String, comment: String?, polygon: String, name: String?, type: Int) {
        self.init()
        self.comment = comment
        self.polygon = polygon
        self.id = id
        self.name = name
        self.type = Int64(type)
    }
   
    /*
        polygon's format: "0 0 0 1 1 1 1 0"
        polygon needs to have even count of coordinates
     */
    
    class func allitems() -> [Rooms] {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Rooms")
        
        
        let results = try? CoreDataHelper.instance.context.fetch(
            fetchRequest)
        
        return results as! [Rooms]
    }
    
    class func maximum() -> Int {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Rooms")
        
        do {
            let results = try CoreDataHelper.instance.context.fetch(fetchRequest)
            return results.count
        } catch {
            return 1
        }
    }
}
