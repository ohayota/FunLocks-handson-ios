//
//  Beacon.swift
//  BeaconSample
//
//  Created by Yota Nakamura on 2020/11/11.
//

import Foundation

// MARK: - 1つのビーコンを表すモデル
struct Beacon: Codable, Identifiable {
    let id: Int
    let name: String
    let info: Info
}

// MARK: - ビーコンが持つ各値をまとめたモデル
struct Info: Codable {
    let uuid: String
    let major: Int
    let minor: Int
}
