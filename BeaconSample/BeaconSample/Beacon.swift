//
//  Beacon.swift
//  BeaconSample
//
//  Created by Yota Nakamura on 2020/11/11.
//

import SwiftUI
import CoreLocation

struct Beacon: Hashable, Codable, Identifiable {
    var id: Int
    var name: String
    var info = CLBeacon()
//    var info: Info
    // {"uuid":UUID, "major":NSNumber, "minor":NSNumber, "proximity":CLProximity, "accuracy":CLLocationAccuracy, "rssi":Int, "timestamp":Date}
    // CLBeacon: https://developer.apple.com/documentation/corelocation/clbeacon
    
    private enum CodingKeys: String, CodingKey { case id, name }
}
