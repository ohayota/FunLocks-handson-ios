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
    let info: Info
}

struct Info: Codable {
    let uuid: String
    let major: Int
    let minor: Int
}
