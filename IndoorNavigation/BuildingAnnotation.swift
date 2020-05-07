//
//  BuildingAnnotation.swift
//  indoor navigation a
//
//  Created by Fedor Korshikov on 19/09/2019.
//  Copyright © 2019 Исмагил Сайфутдинов. All rights reserved.
//

import Foundation
import MapKit

class SanFranciscoAnnotation: NSObject, MKAnnotation {
    
    // This property must be key-value observable, which the `@objc dynamic` attributes provide.
    @objc dynamic var coordinate = CLLocationCoordinate2D(latitude: 55.761_505, longitude: 37.633_397)
    
    // Required if you set the annotation view's `canShowCallout` property to `true`
    var title: String? = NSLocalizedString("Мясницкая 20", comment: "SF annotation")
    
    // This property defined by `MKAnnotation` is not required.
//    var subtitle: String? = NSLocalizedString("SAN_FRANCISCO_SUBTITLE", comment: "SF annotation")

}
