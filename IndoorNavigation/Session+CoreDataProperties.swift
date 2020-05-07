//
//  Session+CoreDataProperties.swift
//  indoor navigation a
//
//  Created by Исмагил Сайфутдинов on 09/02/2019.
//  Copyright © 2019 Исмагил Сайфутдинов. All rights reserved.
//
//

import Foundation
import CoreData


extension Session {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Session> {
        return NSFetchRequest<Session>(entityName: "Session")
    }

    @NSManaged public var comment: String?
    @NSManaged public var cordinates: String?
    @NSManaged public var dt_end: NSDate?
    @NSManaged public var dt_modification: NSDate?
    @NSManaged public var dt_start: NSDate?
    @NSManaged public var id: String?
    @NSManaged public var roomsrelationship: Rooms?

}
