//
//  Session+CoreDataClass.swift
//  TableData
//
//  Created by Александр Воронцов on 05/02/2019.
//  Copyright © 2019 Александр Воронцов. All rights reserved.
//
//

import Foundation
import CoreData

@objc(Session)
public class Session: NSManagedObject {
    override public class func entity() -> NSEntityDescription {
        return NSEntityDescription.entity(forEntityName: "Session", in: CoreDataHelper.instance.context)!
    }
    convenience init() {
        self.init(entity: Session.entity(), insertInto: CoreDataHelper.instance.context)
    }
    convenience init(id: String, cordinates: String?, dt_start: NSDate?, dt_end: NSDate?, dt_modification: NSDate?, comment: String?) {
        self.init()
        self.id = id
        self.cordinates = cordinates
        self.dt_start = dt_start
        self.dt_end = dt_end
        self.dt_modification = dt_modification
        self.comment = comment
    }
    class func allitems() -> [Session] {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Session")
        
        let results = try? CoreDataHelper.instance.context.fetch(
            fetchRequest)
        
        return results as! [Session]
    }
    class func maximum() -> Int {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Session")
        
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
