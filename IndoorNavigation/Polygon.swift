//
//  Polygon.swift
//  indoor navigation a

import Foundation
import CoreGraphics

class Polygon {
    var points: [(x: Double, y: Double)]
    
    init(points: [(x: Double, y: Double)]) {
        self.points = points
    }
    
    func square() -> Double {
        var ret = 0.0
        
        for index in 1 ..< points.count - 1 {
            let firstVector = (x: points[index].x - points[0].x, y: points[index].y - points[0].y)
            let secondVector = (x: points[index + 1].x - points[0].x, y: points[index + 1].y - points[0].y)
            
            ret += crossProduct(firstVector: firstVector, secondVector: secondVector)
        }
        
        return ret
    }
    func printPoints (){
        print (points)
    }
    
    func isInside(point: (x: Double, y: Double)) -> Bool {
        let secondPoint = (x: Double.random(in: 1000000 ... 2000000), y: Double.random(in: 1000000 ... 2000000))
        var intersectionsCount = 0
        
        for index in 0 ..< points.count {
            if indoor_navigation_a.isInside(point: point, first: points[index], second: points[(index + 1) % points.count]) {
                intersectionsCount += 1
                continue
            }
            
            if indoor_navigation_a.isInside(point: secondPoint, first: points[index], second: points[(index + 1) % points.count]) {
                intersectionsCount += 1
                continue
            }
            
            if indoor_navigation_a.isInside(point: points[index], first: point, second: secondPoint) {
                intersectionsCount += 1
                continue
            }
            
            if indoor_navigation_a.isInside(point: points[(index + 1) % points.count], first: point, second: secondPoint) {
                intersectionsCount += 1
                continue
            }
            
            // A - point
            // B - secondPoint
            // C - points[index]
            // D - points[(index + 1) % points.count]
            
            let AB = (x: secondPoint.x - point.x, y: secondPoint.y - point.y)
            let BA = (x: -secondPoint.x + point.x, y: -secondPoint.y + point.y)
            let AC = (x: points[index].x - point.x, y: points[index].y - point.y)
            let CA = (x: -points[index].x + point.x, y: -points[index].y + point.y)
            let AD = (x: points[(index + 1) % points.count].x - point.x, y: points[(index + 1) % points.count].y - point.y)
            let DA = (x: -points[(index + 1) % points.count].x + point.x, y: -points[(index + 1) % points.count].y + point.y)
            let BC = (x: points[index].x - secondPoint.x, y: points[index].y - secondPoint.y)
            let CB = (x: -points[index].x + secondPoint.x, y: -points[index].y + secondPoint.y)
            let BD = (x: points[(index + 1) % points.count].x - secondPoint.x, y: points[(index + 1) % points.count].y - secondPoint.y)
            let DB = (x: -points[(index + 1) % points.count].x + secondPoint.x, y: -points[(index + 1) % points.count].y + secondPoint.y)
            let CD = (x: points[(index + 1) % points.count].x - points[index].x, y: points[(index + 1) % points.count].y - points[index].y)
            let DC = (x: -points[(index + 1) % points.count].x + points[index].x, y: -points[(index + 1) % points.count].y + points[index].y)
            
            if crossProduct(firstVector: AB, secondVector: AC).sign == crossProduct(firstVector: AB, secondVector: AD).sign {
                continue
            }
            if crossProduct(firstVector: CD, secondVector: CA).sign == crossProduct(firstVector: CD, secondVector: CB).sign {
                continue
            }
            if crossProduct(firstVector: BA, secondVector: BC).sign == crossProduct(firstVector: BA, secondVector: BD).sign {
                continue
            }
            if crossProduct(firstVector: DC, secondVector: DA).sign == crossProduct(firstVector: DC, secondVector: DB).sign {
                continue
            }
            
            intersectionsCount += 1
        }
        
        return intersectionsCount % 2 == 1
    }
    
    func findCenter () -> CGPoint { // найти центр комнаты
        if points.capacity==0 { return CGPoint (x:0, y:0) } //если точек нет
        var minX = points[0].x
        var minY = points[0].y
        var maxX = points[0].x
        var maxY = points[0].y
        
        for point in points {
            if point.x < minX{
                minX = point.x
            }
            if point.y < minY{
                minY = point.y
            }
            if point.x > maxX{
                maxX = point.x
            }
            if point.y > maxY{
                maxY = point.y
            }
        }
        let resX = minX + (maxX-minX)/2
        let resY = minY + (maxY-minY)/2
        return CGPoint(x: resX, y: resY)
    }
}
