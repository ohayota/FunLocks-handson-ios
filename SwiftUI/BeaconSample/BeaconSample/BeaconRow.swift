//
//  BeaconRow.swift
//  BeaconSample
//
//  Created by Yota Nakamura on 2020/11/11.
//

import SwiftUI

struct BeaconRow: View {
    var beacon: Beacon

    var body: some View {
        HStack {
            Image("MyImage")
                .resizable()
                .frame(width: 50, height: 50)
                .clipShape(Circle())
                .overlay(
                    Circle().stroke(Color.gray, lineWidth: 2))
            Text(beacon.name)
            Spacer()
        }
    }
}

struct BeaconRow_Previews: PreviewProvider {
    static var previews: some View {
        BeaconRow(beacon: beaconData[0])
    }
}
