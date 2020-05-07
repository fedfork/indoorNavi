//
//  GraphEdge.swift
//  indoor navigation a
//
//  Created by Исмагил Сайфутдинов on 01/02/2019.
//  Copyright © 2019 Исмагил Сайфутдинов. All rights reserved.
//

import Foundation

/*class GraphEdge: Hashable, Codable {
    
    var hashValue: Int {
        return identifier
    }
    
    static func == (lhs: GraphEdge, rhs: GraphEdge) -> Bool {
        return lhs.identifier == rhs.identifier
    }
    
    
    var identifier: Int
    var from: GraphVertex
    var to: GraphVertex
    var length: Double
    var doorCoordinates: [[Double]]?
    
    init(from: GraphVertex, to: GraphVertex, length: Double, doorCoordinates: [[Double]]) {
        self.identifier = GraphEdge.getUniqueIdentifier()
        self.from = from
        self.to = to
        self.length = length
        self.doorCoordinates = doorCoordinates
    }
    
    private static var uniqueIdentifier = 0
    private static func getUniqueIdentifier() -> Int{
        uniqueIdentifier += 1
        return uniqueIdentifier
    }
}*/
