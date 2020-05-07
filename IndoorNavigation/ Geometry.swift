//
//   Geometry.swift
//  indoor navigation a


import Foundation

let eps = 1e-4

func crossProduct(firstVector: (x: Double, y: Double), secondVector: (x: Double, y: Double)) -> Double {
    return firstVector.x * secondVector.y - firstVector.y * secondVector.x
}

func dotProduct(firstVector: (x: Double, y: Double), secondVector: (x: Double, y: Double)) -> Double {
    return firstVector.x * secondVector.x + firstVector.y * secondVector.y
}

func sqr(_ value: Double) -> Double {
    return value * value
}

func distance(_ first: (x: Double, y: Double), _ second: (x: Double, y: Double)) -> Double {
    return sqrt(sqr(first.x - second.x) + sqr(first.y - second.y))
}

func circlesIntersection(first: (x: Double, y: Double, r: Double), second: (x: Double, y: Double, r: Double)) -> [(x: Double, y: Double)]? {
    let dist = sqrt(sqr(first.x - second.x) + sqr(first.y - second.y))
    if dist > first.r + second.r || dist + min(first.r, second.r) < max(first.r, second.r) {
        return nil
    }
    
    
    let x = (sqr(dist) - sqr(second.r) + sqr(first.r)) / 2 / dist
    let y = sqrt(sqr(first.r) - sqr(x))
    let vector = (x: (second.x - first.x) / dist, y: (second.y - first.y) / dist)
    
    let firstPoint = (x: first.x + vector.x * x + vector.y * y, y: first.y + vector.y * x - vector.x * y)
    let secondPoint = (x: first.x + vector.x * x - vector.y * y, y: first.y + vector.y * x + vector.x * y)
    
    return [firstPoint, secondPoint]
}

func isInside(point: (x: Double, y: Double), first: (x: Double, y: Double), second: (x: Double, y: Double)) -> Bool {
    let firstVector = (x: first.x - point.x, y: first.y - point.y)
    let secondVector = (x: second.x - point.x, y: second.y - point.y)
    
    if abs(crossProduct(firstVector: firstVector, secondVector: secondVector)) < eps {
        if first <= second {
            return first <= point && point <= second
        }
        else {
            return second <= point && point <= first
        }
    }
    
    return false
}

extension Double {
    func sign() -> Int {
        if self > 0 {
            return 1
        }
        if self < 0 {
            return -1
        }
        
        return 0
    }
}
