//
//  BeaconList.swift
//  BeaconSample
//
//  Created by Yota Nakamura on 2020/11/11.
//

import SwiftUI

struct BeaconList: View {
    var body: some View {
        List(beaconData) { beacon in
            BeaconRow(beacon: beacon)
        }
    }
}

struct BeaconList_Previews: PreviewProvider {
    static var previews: some View {
        BeaconList()
    }
}
