//
//  Beacon.swift
//  BeaconSample
//
//  Created by Yota Nakamura on 2020/11/11.
//

import SwiftUI
import CoreLocation

struct Beacon: Codable, Identifiable {
    var id: Int
    var name: String
    var imageName: String
    var info: Info
    // {"uuid":UUID, "major":NSNumber, "minor":NSNumber, "proximity":CLProximity, "accuracy":CLLocationAccuracy, "rssi":Int, "timestamp":Date}
    // CLBeacon: https://developer.apple.com/documentation/corelocation/clbeacon
    
//    private enum CodingKeys: String, CodingKey { case id, name, imageName }
}

struct Info: Codable {
    var uuid: String
    var major: Int
    var minor: Int

//    private enum CodingKeys: String, CodingKey { case uuid, mahor, minor }
}
