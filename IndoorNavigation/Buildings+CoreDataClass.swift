//
//  Buildings+CoreDataClass.swift
//  TableData


import Foundation
import CoreData

@objc(Buildings)
public class Buildings: NSManagedObject {
    override public class func entity() -> NSEntityDescription {
        return NSEntityDescription.entity(forEntityName: "Buildings", in: CoreDataHelper.instance.context)!
    }
    convenience init() {
        self.init(entity: Buildings.entity(), insertInto: CoreDataHelper.instance.context)
    }
    convenience init(id: String, name: String, comment: String, adress: String) {
        
        self.init()
        self.name = name
        self.id = id
        self.comment = comment
        self.adress = adress
    }
    class func allitems() -> [Buildings] {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Buildings")
        
        let results = try? CoreDataHelper.instance.context.fetch(
            fetchRequest)
        
        return results as! [Buildings]
    }
    class func maximum() -> Int {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Buildings")
    
        do {
            let results = try CoreDataHelper.instance.context.fetch(fetchRequest)
            return results.count
        } catch {
            return 1
        }
    }

}
