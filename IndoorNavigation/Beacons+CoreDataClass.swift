//
//  Beacons+CoreDataClass.swift
//  TableData

import Foundation
import CoreData

@objc(Beacons)
public class Beacons: NSManagedObject {
    override public class func entity() -> NSEntityDescription {
        return NSEntityDescription.entity(forEntityName: "Beacons", in: CoreDataHelper.instance.context)!
    }
    convenience init() {
        self.init(entity: Beacons.entity(), insertInto: CoreDataHelper.instance.context)
    }
    convenience init(id: String, name: String?, coordinates: String?, majorminor: String?, uuid: String?, comment: String?, height : String?) {
        self.init()
        self.id = id
        self.name = name
        self.coordinates = coordinates ?? ""
        self.majorminor = majorminor! 
        self.uuid = uuid ?? ""
        self.comment = comment
        self.height = height
    }
    

    /*
     coordinates's format: "0 0"
     coordinates need to have 2 coordinates
     */
    
    class func allitems() -> [Beacons] {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Beacons")
        
        let results = try? CoreDataHelper.instance.context.fetch(
            fetchRequest)
        
        return results as! [Beacons]
    }
    class func maximum() -> Int {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Beacons")
        
        fetchRequest.sortDescriptors = [
            NSSortDescriptor(key: "id", ascending: true)
        ]
        do {
            let results = try CoreDataHelper.instance.context.fetch(fetchRequest)
            return results.count
        } catch {
            return 1
        }
    }
}
