//
//  BeaconSupport.swift
//  indoor navigation a
//
//  Created by Исмагил Сайфутдинов on 08/02/2019.
//  Copyright © 2019 Исмагил Сайфутдинов. All rights reserved.
//

import Foundation

func distanceFromRSSI(rssi: Int) -> Double? {
    let txPower = -59.0 //hard coded power value. Usually ranges between -59 to -65
    
    if (rssi == 0) {
        return nil
    }
    
    let ratio = Double(rssi) * 1.0 / txPower;
    
    if ratio < 1.0 {
        return pow(ratio, 10)
    }
        
    else {
        let distance =  0.89976 * pow(ratio, 7.7095) + 0.111
        return distance;
    }
}
