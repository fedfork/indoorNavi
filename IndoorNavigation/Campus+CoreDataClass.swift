//
//  Campus+CoreDataClass.swift
//  TableData

import Foundation
import CoreData

@objc(Campus)
public class Campus: NSManagedObject {
    override public class func entity() -> NSEntityDescription {
        return NSEntityDescription.entity(forEntityName: "Campus", in: CoreDataHelper.instance.context)!
    }
    convenience init() {
        self.init(entity: Campus.entity(), insertInto: CoreDataHelper.instance.context)
    }
    convenience init(id: String, name: String, comment: String) {
        self.init()
        self.name = name
        self.id = id
        self.comment = comment
    }
    class func allitems() -> [Campus] {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Campus")

        
        let results = try? CoreDataHelper.instance.context.fetch(
            fetchRequest)
        
        return results as! [Campus]
    }

    class func maximum() -> Int {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Campus")
        
        do {
            let results = try CoreDataHelper.instance.context.fetch(fetchRequest)
            return results.count
        } catch {
            return 1
        }
    }
}
