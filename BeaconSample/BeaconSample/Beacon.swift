//
//  Beacon.swift
//  BeaconSample
//
//  Created by Yota Nakamura on 2020/11/11.
//

import SwiftUI

struct Beacon: Hashable, Codable {
    var id: Int
    var ssid: String
    var name: String
}
