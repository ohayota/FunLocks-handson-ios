//
//  Beacon.swift
//  BeaconSample
//
//  Created by Yota Nakamura on 2020/11/11.
//

import SwiftUI
import CoreLocation

struct Beacon: Codable, Identifiable {
    let id: Int
    let name: String
    let imageName: String
    let info: Info
    // {"uuid":UUID, "major":NSNumber, "minor":NSNumber, "proximity":CLProximity, "accuracy":CLLocationAccuracy, "rssi":Int, "timestamp":Date}
    // CLBeacon: https://developer.apple.com/documentation/corelocation/clbeacon
    
//    private enum CodingKeys: String, CodingKey { case id, name, imageName }
}

struct Info: Codable {
    let uuid: String
    let major: Int
    let minor: Int
    var timestamp: Date?

//    private enum CodingKeys: String, CodingKey { case uuid, mahor, minor }
}
