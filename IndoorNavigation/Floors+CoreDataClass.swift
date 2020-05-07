//
//  Floors+CoreDataClass.swift
//  TableData

import Foundation
import CoreData

@objc(Floors)
public class Floors: NSManagedObject {
    override public class func entity() -> NSEntityDescription {
        return NSEntityDescription.entity(forEntityName: "Floors", in: CoreDataHelper.instance.context)!
    }
    convenience init() {
        self.init(entity: Floors.entity(), insertInto: CoreDataHelper.instance.context)
    }
    convenience init(id: String, name: String?, comment: String? ) {
        self.init()
        self.name = name
        self.id = id
        self.comment = comment
    }
    class func allitems() -> [Floors] {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Floors")
        
        
        let results = try? CoreDataHelper.instance.context.fetch(
            fetchRequest)
        
        return results as! [Floors]
    }
    class func maximum() -> Int {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Floors")
        do {
            let results = try CoreDataHelper.instance.context.fetch(fetchRequest)
            return results.count
        } catch {
            return 1
        }
    }
}
